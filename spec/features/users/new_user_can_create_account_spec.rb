require 'rails_helper'

RSpec.feature 'New User can Create an Account' do
  let!(:state) { create(:state) }
  context 'when not logged in' do
    context 'when all required fields are entered' do
      scenario 'a visitor can create an account' do
        visit root_path

        expect(page).to have_link 'Sign Up', href: new_user_path

        click_link 'Sign Up'

        expect(current_path).to eq new_user_path

        fill_in 'Email', with: 'test@test.com'
        fill_in 'First Name', with: 'Test'
        fill_in 'Last Name', with: 'Last'
        fill_in 'Address', with: '123 Street Ave'
        fill_in 'City', with: 'Somewhere'
        select state.abbr, from: 'user[address][city][state_id]'
        fill_in 'Zipcode', with: '12345'
        # select 'Shipping', from: 'address_type'
        fill_in 'Password', with: '123abc'

        click_button 'Create User'

        expect(current_path).to eq dashboard_path
        expect(page).to have_content 'Logged in as Test Last'
        expect(page).to have_content 'Your Profile'
        expect(page).to have_content '123 Street Ave'
        expect(page).to have_content 'Somewhere'
        expect(page).to have_content '12345'
        expect(page).to have_content 'CO'
        expect(page).to have_link 'Logout', href: logout_path
        expect(page).not_to have_link 'Login', href: login_path
        expect(page).not_to have_link 'Sign Up', href: new_user_path
      end
    end
    context 'when a required field is not included' do
      scenario 'shows an error for missing first name' do
        visit new_user_path

        fill_in 'Email', with: 'test@test.com'
        fill_in 'First Name', with: ''
        fill_in 'Last Name', with: 'Last'
        fill_in 'Address', with: '123 Street Ave'
        fill_in 'City', with: 'Somewhere'
        select state.abbr, from: 'user[address][city][state_id]'
        fill_in 'Zipcode', with: '12345'
        # select 'Shipping', from: 'address_type'
        fill_in 'Password', with: '123abc'

        click_button 'Create User'

        expect(page).to have_content "First name can't be blank"
      end

      scenario 'shows an error for missing last name' do
        visit new_user_path

        fill_in 'Email', with: 'test@test.com'
        fill_in 'First Name', with: 'First'
        fill_in 'Last Name', with: ''
        fill_in 'Address', with: '123 Street Ave'
        fill_in 'City', with: 'Somewhere'
        select state.abbr, from: 'user[address][city][state_id]'
        fill_in 'Zipcode', with: '12345'
        # select 'Shipping', from: 'address_type'
        fill_in 'Password', with: '123abc'

        click_button 'Create User'

        expect(page).to have_content "Last name can't be blank"
      end

      scenario 'shows an error for missing email' do
        visit new_user_path

        fill_in 'Email', with: ''
        fill_in 'First Name', with: 'First'
        fill_in 'Last Name', with: 'Last'
        fill_in 'Address', with: '123 Street Ave'
        fill_in 'City', with: 'Somewhere'
        select state.abbr, from: 'user[address][city][state_id]'
        fill_in 'Zipcode', with: '12345'
        # select 'Shipping', from: 'address_type'
        fill_in 'Password', with: '123abc'

        click_button 'Create User'

        expect(page).to have_content "Email can't be blank"
      end

      scenario 'shows an error for duplicate email' do
        user = create(:user)
        visit new_user_path

        fill_in 'Email', with: user.email
        fill_in 'First Name', with: 'First'
        fill_in 'Last Name', with: 'Last'
        fill_in 'Address', with: '123 Street Ave'
        fill_in 'City', with: 'Somewhere'
        select state.abbr, from: 'user[address][city][state_id]'
        fill_in 'Zipcode', with: '12345'
        # select 'Shipping', from: 'address_type'
        fill_in 'Password', with: '123abc'

        click_button 'Create User'

        expect(page).to have_content "Email has already been taken"
      end
    end
  end
end
