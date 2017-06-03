require 'rails_helper'

RSpec.describe "User wants to login" do

  before do
    @user = create(:user)
    visit login_path
  end

  scenario "and they log in" do

    within("form") do
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_on "Login"
    end

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Logged in as #{@user.email}")
    expect(page).to have_content("#{@user.email}")
    expect(page).to have_content("Logout")
  end

  scenario "and they enter wrong password" do

    within("form") do
      fill_in "Email", with: @user.email
      fill_in "Password", with: 'hogwash'
      click_on "Login"
    end

    expect(current_path).to eq('/login')
    expect(page).to have_content('Incorrect Password or Username')
  end

  scenario "and they enter wrong email" do

    within("form") do
      fill_in "Email", with: 'celinedion'
      fill_in "Password", with: @user.password
      click_on "Login"
    end

    expect(current_path).to eq('/login')
    expect(page).to have_content('Incorrect Password or Username')
  end
end
