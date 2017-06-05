require 'rails_helper'

RSpec.feature 'visitor can remove an item in the cart' do
  describe 'visitor can see an item and remove it' do
    scenario 'a visitor sees and removes a single item from the cart' do
      item = create(:item)
      visit items_path
      expect(page).to have_content(item.name)

      click_button "Add to Cart"
      expect(page).to have_content("You now have 1 #{item.name} in your cart.")
      expect(page).to have_content("Cart: 1")

      visit cart_path
      expect(current_path).to eq("/cart")

      click_on "Remove"

      expect(current_path).to eq("/cart")
      # expect(page).to have_css(".alert-success", text: "Successfully removed #{item.name} from your cart")
      expect(page).to have_content("Successfully removed #{item.name} from your cart")
      expect(page).to have_link("#{item.name}", item_path(item))
      expect(page).to have_content("Cart: 0")
    end

    scenario 'a visitor sees and removes multiple items from the cart' do
      item = create(:item)
      visit items_path
      expect(page).to have_content(item.name)

      click_button "Add to Cart"
      click_button "Add to Cart"
      expect(page).to have_content("You now have 2 #{item.name}s in your cart.")
      expect(page).to have_content("Cart: 2")

      visit cart_path
      expect(current_path).to eq("/cart")

      click_on "Remove"

      expect(current_path).to eq("/cart")
      # expect(page).to have_css(".alert-success", text: "Successfully removed #{item.name} from your cart")
      expect(page).to have_content("Successfully removed #{item.name} from your cart")
      expect(page).to have_link("#{item.name}", item_path(item))
      expect(page).to have_content("Cart: 0")
    end
  end
end
