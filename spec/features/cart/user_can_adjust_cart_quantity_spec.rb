require 'rails_helper'

RSpec.feature 'Visitor can adjust cart quantity' do
  describe 'a visitor can change quantity of an item in their cart' do
    let(:item) { create(:item) }

    scenario 'increase quantity in the cart' do
      cart = build(:cart, contents: { item.id.to_s => 1 })
      allow_any_instance_of(ApplicationController).to receive(:current_cart).and_return(cart)

      visit cart_path

      expect(page).to have_content(item.name)
      within(".item-#{item.id}") do
        expect(page).to have_content('Quantity: ')
        expect(page).to have_selector('input[value="1"]')
      end
      expect(page).to have_content("Total: $#{item.price}")

      within(".item-#{item.id}") do
        fill_in "quantity", with: "2"
        click_on('Update Quantity')
      end

      expect(current_path).to eq(cart_path)
      expect(page).to have_content("Quantity of #{item.name} updated.")
      within(".item-#{item.id}") do
        expect(page).to have_content('Quantity: ')
        expect(page).to have_selector('input[value="2"]')
      end
      expect(page).to have_content("Total: $#{item.price * 2}")
    end

    scenario 'decrease quantity in the cart' do
      cart = build(:cart, contents: { item.id.to_s => 2 })
      allow_any_instance_of(ApplicationController).to receive(:current_cart).and_return(cart)

      visit cart_path

      expect(page).to have_content(item.name)
      within(".item-#{item.id}") do
        expect(page).to have_content('Quantity: ')
        expect(page).to have_selector('input[value="2"]')
      end
      expect(page).to have_content("Total: $#{item.price * 2}")

      within(".item-#{item.id}") do
        fill_in "quantity", with: "1"
        click_on('Update Quantity')
      end

      expect(current_path).to eq(cart_path)
      expect(page).to have_content("Quantity of #{item.name} updated.")
      within(".item-#{item.id}") do
        expect(page).to have_content('Quantity: ')
        expect(page).to have_selector('input[value="1"]')
      end
      expect(page).to have_content("Total: $#{item.price}")
    end

  end
end
