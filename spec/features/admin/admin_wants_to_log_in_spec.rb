require 'rails_helper'

RSpec.describe 'Admin wants to log in' do

  xscenario 'and logs in' do
    admin = create(:user, role: :admin)

    visit('/login')

    within("form") do
      fill_in "email", with: admin.username
      fill_in "password", with: admin.password
      click_on "Login"
    end

    expect(current_path).to eq(admin_dashboard_path(admin))
    expect(page).to have_content("Successfully logged in!")
    expect(page).to have_content("#{admin.username}")
    expect(page).to have_content("Logout")
  end
end