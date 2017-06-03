require 'rails_helper'

RSpec.feature 'Visitor can adjust cart quantity' do
  describe 'a visitor can change quantity of an item in their cart' do
    let(:item) { create(:item) }
    let(:cart) { build(:cart, contents: { item.id.to_s => 1 }) }

    scenario 'increase quantity in the cart' do
      @cart = cart

      allow_any_instance_of(ApplicationController).to receive(:current_cart).and_return(cart)

      visit cart_path

      expect(page).to have_content(item.name)
      expect(page).to have_content('Quantity: 1')
      expect(page).to have_content("Total: $#{item.price}")

      # select_quantity_increase
      click_on('Update Cart')

      expect(current_path).to eq(cart_path)
      expect(page).to have_content(order.item.quantity + 1)
      expect(page).to have_content(order.quantity + 1)
    end

    xscenario 'decrease quantity in the cart' do

      visit_cart_path

      expect(page).to have_content(item.name)
      expect(page).to have_content(order.item.quantity)
      expect(page).to have_content(order.quantity)

      # select_quantity_increase
      click_on('Update Cart')

      expect(current_path).to eq(cart_path)
      expect(page).to have_content(order.item.quantity - 1)
      expect(page).to have_content(order.quantity - 1)
    end

  end
end
