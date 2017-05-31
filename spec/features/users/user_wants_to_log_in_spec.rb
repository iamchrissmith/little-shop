require 'rails_helper'

RSpec.describe "User wants to login" do

  before do
    @user = create(:user)
    visit login_path
  end

  scenerio "and they log in" do

    within("form") do
      fill_in "email", with: @user.username
      fill_in "password", with: 'hogwash'
      click_on "Login"
    end

    expect(current_path).to eq(user_path(@user))
    expect(page).to have_content("Successfully logged in!")
    expect(page).to have_content("#{@user.username}")
    expect(page).to have_content("Logout")
  end

  scenerio "and they enter wrong password" do

    within("form") do
      fill_in "email", with: @user.username
      fill_in "password", with: 'hogwash'
      click_on "Login"
    end

    expect(current_path).to eq('/login')
    expect(page).to have_content('Incorrect Password or Username')
  end

  scenerio "and they enter wrong username" do

    within("form") do
      fill_in "email", with: 'celinedion'
      fill_in "password", with: @user.username
      click_on "Login"
    end

    expect(current_path).to eq('/login')
    expect(page).to have_content('Incorrect Password or Username')
  end
end
