require 'rails_helper'

RSpec.feature "Visitor can adjust cart quantity" do
  xscenario "a visitor can change quantity of an item in their cart" do
    context "increase quantity in the cart" do
      let! (:item) { create(:item) }
      let! (:order) { create(:order) }

      visit cart_path

      expect(page).to have_content(item.name)
      expect(page).to have_content(order.item.quantity)
      expect(page).to have_content(order.quantity)

      #select_quantity_increase
      click_on("Update Cart")

      expect(current_path).to eq(cart_path)
      expect(page).to have_content(order.item.quantity + 1)
      expect(page).to have_content(order.quantity + 1)
    end

    context "decrease quantity in the cart" do
      let! (:item) { create(:item) }
      let! (:order) { create(:order) }

      visit_cart_path

      expect(page).to have_content(item.name)
      expect(page).to have_content(order.item.quantity)
      expect(page).to have_content(order.quantity)

      #select_quantity_increase
      click_on("Update Cart")

      expect(current_path).to eq(cart_path)
      expect(page).to have_content(order.item.quantity - 1)
      expect(page).to have_content(order.quantity - 1)
    end

  end
end
