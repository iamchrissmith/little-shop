require 'rails_helper'

RSpec.describe "Visitor wants to see items in cart" do
  let(:item) { create(:item) }

  context "when they do not already have an account" do
    scenario "They see items in cart, create account, and still see items in cart" do
      cart = cart = build(:cart, contents: { item.id.to_s => 1 })
      allow_any_instance_of(ApplicationController).to receive(:current_cart).and_return(cart)

      visit cart_path

      within(".item-#{item.id}") do
        expect(page).to have_content('Quantity: ')
        expect(page).to have_selector('input[value="1"]')
      end
      expect(page).to have_content("Total: $#{item.price}")

      expect(page).to_not have_link "Checkout", href: new_order_path
      within(".checkout") do
        expect(page).to have_link "Create Account", new_user_path

        click_on "Create Account"
      end

      expect(current_path).to eq new_user_path

      fill_in 'First Name', with: 'Dude'
      fill_in 'Last Name', with: "Sky"
      fill_in 'Email', with: 'dude@sky.net'
      fill_in 'Password', with: 'dude'
      click_button 'Create User'

      expect(current_path).to eq dashboard_path
      click_on "Cart: 1"
      expect(current_path).to eq cart_path

      within(".item-#{item.id}") do
        expect(page).to have_content('Quantity: ')
        expect(page).to have_selector('input[value="1"]')
      end
      expect(page).to have_content("Total: $#{item.price}")

      expect(page).to have_link "Checkout", href: new_order_path
      within(".checkout") do
        expect(page).to_not have_link "Create Account", new_user_path
      end
    end
  end

  context "when they already have an account" do
    let(:user) { create(:user) }
    scenario "They see items in cart, login, and still see items in cart" do
      cart = cart = build(:cart, contents: { item.id.to_s => 1 })
      allow_any_instance_of(ApplicationController).to receive(:current_cart).and_return(cart)

      visit cart_path

      within(".item-#{item.id}") do
        expect(page).to have_content('Quantity: ')
        expect(page).to have_selector('input[value="1"]')
      end
      expect(page).to have_content("Total: $#{item.price}")

      expect(page).to_not have_link "Checkout", href: new_order_path
      within(".checkout") do
        expect(page).to have_link "Login", login_path

        click_on "Login"
      end

      expect(current_path).to eq login_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Login'

      expect(current_path).to eq dashboard_path
      click_on "Cart: 1"
      expect(current_path).to eq cart_path

      within(".item-#{item.id}") do
        expect(page).to have_content('Quantity: ')
        expect(page).to have_selector('input[value="1"]')
      end
      expect(page).to have_content("Total: $#{item.price}")

      expect(page).to have_link "Checkout", href: new_order_path
      within(".checkout") do
        expect(page).to_not have_link "Login", login_path
      end
    end
  end
end
