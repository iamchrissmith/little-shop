require 'rails_helper'

RSpec.describe 'Admin cannot modify other users data' do

  before do
    @user = create(:user)
    @admin = create(:user, :as_admin)

    allow_any_instance_of(ApplicationController).to recieve(:current_user).and_return(@admin)
  end

  scenario 'admin can visit their own show page' do
    visit(user_path(@admin))

    expect(page).to have_content("#{admin.name}")
  end

  scenario 'admin can edit their own info' do
    visit(user_path(@admin))
    click_link 'Edit Account'

    expect(page).to have_content("Edit your account")

    fill_in 'First Name', with: 'Fiddlefaddle'
    click_button 'Submit'

    expect(page).to have_current_path(user_path(@admin))
    expect(page).to have_content('Fiddlefaddle')
  end

  scenario 'admin cannot visit a users show page' do
    visit(user_path(@user))

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario 'admin cannot see a users cart' do
    visit(user_cart_path(@user))

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario 'admin cannot edit a user' do
    visit(edit_user_path(@user))

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end