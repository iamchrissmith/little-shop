require 'rails_helper'

RSpec.describe 'Admin cannot modify other users data' do

  before do
    @user = create(:user)
    @admin = create(:user, role: 'admin')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  scenario 'admin can visit their own show page' do
    visit(admin_dashboard_path)

    expect(page).to have_content("#{@admin.first_name}")
    expect(page).to have_content("#{@admin.last_name}")
  end

  xscenario 'admin can edit their own info' do
    visit(user_path(@admin))
    click_link 'Edit Account'

    expect(page).to have_content("Edit your account")

    fill_in 'First Name', with: 'Fiddlefaddle'
    click_button 'Submit'

    expect(page).to have_current_path(user_path(@admin))
    expect(page).to have_content('Fiddlefaddle')
  end

  scenario 'admin cannot visit a users dashboard path' do
    visit(dashboard_path)

    expect(page).to have_current_path(admin_user_path(@admin))
  end

  xscenario 'admin cannot see a users cart' do
    visit(user_cart_path(@user))

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  xscenario 'admin cannot edit a user' do
    visit(edit_user_path(@user))

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
