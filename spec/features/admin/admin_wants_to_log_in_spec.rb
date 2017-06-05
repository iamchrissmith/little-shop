require 'rails_helper'

RSpec.describe 'Admin wants to log in' do

  scenario 'and logs in' do
    admin = create(:user, role: :admin)

    visit('/login')

    within("form") do
      fill_in "Email", with: admin.email
      fill_in "Password", with: admin.password
      click_on "Login"
    end

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content("Admin Logged in as #{admin.email}")
    expect(page).to have_content("#{admin.email}")
    expect(page).to have_content("#{admin.first_name}")
    expect(page).to have_content("#{admin.last_name}")
    expect(page).to have_content("Logout")
  end
end