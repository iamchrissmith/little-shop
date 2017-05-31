require 'rails_helper'

RSpec.feature "New User can Create an Account" do
  context "when not logged in" do
    scenario "a visitor can create an account" do
      visit root_path

      expect(page).to have_link "Login", href: login_path

      click_link "Login"

      expect(current_path).to eq login_path
      expect(page).to have_link "Create Account", href: new_user_path

      click_link "Create Account"

      fill_in "Email", with: "test@test.com"
      fill_in "First Name", with: "Test"
      fill_in "Last Name", with: "Last"
      fill_in "Address", with: "123 Street Ave"
      fill_in "City", with: "Somewhere"
      select "CO", from: "state"
      fill_in "ZipCode", with: "12345"
      select "Home", from: "address_type"
      fill_in "Password", with: "123abc"

      click_button "Submit"

      expect(current_path).to eq dashboard_path
      expect(page).to have_content "Logged in as Test Last"
      expect(page).to have_content "Your Profile"
      expect(page).to have_content "123 Street Ave"
      expect(page).to have_content "Somewhere"
      expect(page).to have_content "12345"
      expect(page).to have_content "CO"
      expect(page).to have_link "Logout", href: logout_path
      expect(page).not_to have_link "Login", href: login_path
    end
  end
end
