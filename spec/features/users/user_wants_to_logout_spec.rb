require 'rails_helper'

RSpec.describe "User wants to logout" do

  xscenario "and they are successfully logged out" do
    user = create(:user)

    # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit login_path

    within("form") do
      fill_in "email", with: user.email
      fill_in "password", with: user.password
      click_on "Login"
    end

    click_on "Logout"

    expect(page).to have_current_path(root_path)
    expect(page).to have_content("Successfully logged out!")
    expect(page).to have_content("Login")
  end
end
