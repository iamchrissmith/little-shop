require 'rails_helper'

RSpec.feature "user can add items to a cart" do
  context "as a guest user is not logged in"
    it "user can add item to cart from items page" do
      item = create(:item)

      visit items_path
      expect(page).to have_content(item.name)

      click_button "Add to Cart"
      expect(page).to have_content("You added 1 #{item.name} to your cart.")
    end

    it "user can add item to cart from item view page" do
      item = create(:item)

      visit items_path
      expect(page).to have_content(item.name)

      click_link item.name
      expect(page).to have_content(item.name)

      click_button "Add to Cart"
      expect(page).to have_content("You added 1 #{item.name} to your cart.")
    end

    it "total number of particular item in cart increments" do
      item = create(:item)

      visit items_path
      expect(page).to have_content(item.name)

      click_button "Add to Cart"
      click_button "Add to Cart"

      expect(page).to have_content("You have 2 #{item.name}s in your cart.")
    end    

    it "total number of items in cart increments in nav bar" do
      item = create(:item)

      visit items_path
      expect(page).to have_content(item.name)

      click_button "Add to Cart"
      click_button "Add to Cart"
      
      within "header nav" do
        expect(page).to have_content("Cart: 2")
      end
    end   

    it "total number of items in cart increments in view cart page" do
      item = create(:item)

      visit items_path
      expect(page).to have_content(item.name)

      click_button "Add to Cart"
      click_button "Add to Cart"
      
      within "header nav" do
        expect(page).to have_content("Cart: 2")
        click_link ("Cart: 2")
      end

      expect(current_path).to eq "/cart"
      #expect(page).to have_css("img[src*='https://support.apple.com/library/content/dam/edam/applecare/images/en_US/macbookpro/macos-sierra-macbook-pro-thunderbolt3-hero.jpg']")
      # (need to add image to Factory girl)
      expect(page).to have_content(item.name)
      expect(page).to have_content(item.description)
      expect(page).to have_content(item.price)
      expect(page).to have_content("Quantity: 2")
      # expect(page).to have_content("Total: $600")

    end  
  end
  
end