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

  scenario 'admin can edit their own info' do
    visit(edit_user_path(@admin))

    expect(page).to have_content("Edit Profile")

    fill_in 'Last Name', with: 'Fiddlefaddle'
    click_on 'Update User'

    expect(page).to have_content('Profile Updated')
    expect(page).to have_current_path(user_path(@admin))
    expect(page).to have_content('Fiddlefaddle')
  end

  scenario 'admin cannot visit a users dashboard path' do
    @user = create(:user, first_name: 'Bombdiggity')
    visit(user_path(@admin))
    expect(page).to have_content(@admin.first_name)

    visit(user_path(@user))
    expect(page).to have_content(@admin.first_name)
    expect(page).to_not have_content(@user.first_name)
  end
end
