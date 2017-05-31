require 'rails_helper'

RSpec.feature "user can add items to a cart" do
  context "as a guest user is not logged in"
    it "user can add item to cart from items page" do
      category = Category.create(name: "Tech")
      category.items = Item.create(name: "computer",
                                  desc: "makes a rock think",
                                  price: 300,
                                  status: 0,
                                  photo: "https://support.apple.com/library/content/dam/edam/applecare/images/en_US/macbookpro/macos-sierra-macbook-pro-thunderbolt3-hero.jpg"
      )

      visit items_path
      expect(page).to have_content("computer")

      click_button "Add to Cart"
      expect(page).to have_content("You added 1 computer to your cart.")
    end

    it "user can add item to cart from item view page" do
      category = Category.create(name: "Tech")
      category.items = Item.create(name: "computer",
                                  desc: "makes a rock think",
                                  price: 300,
                                  status: 0,
                                  photo: "https://support.apple.com/library/content/dam/edam/applecare/images/en_US/macbookpro/macos-sierra-macbook-pro-thunderbolt3-hero.jpg"
      )

      visit items_path
      expect(page).to have_content("computer")

      click_button "Add to Cart"
      expect(page).to have_content("You added 1 computer to your cart.")
    end

    it "user can add item to cart from item view page" do
      category = Category.create(name: "Tech")
      category.items = Item.create(name: "computer",
                                  desc: "makes a rock think",
                                  price: 300,
                                  status: 0,
                                  photo: "https://support.apple.com/library/content/dam/edam/applecare/images/en_US/macbookpro/macos-sierra-macbook-pro-thunderbolt3-hero.jpg"
      )

      visit items_path
      expect(page).to have_content("computer")

      click_button "Add to Cart"
      expect(page).to have_content("You have 1 computer in your cart.")
    end

    it "total number of particular item in cart increments" do
      category = Category.create(name: "Tech")
      category.items = Item.create(name: "computer",
                                  desc: "makes a rock think",
                                  price: 300,
                                  status: 0,
                                  photo: "https://support.apple.com/library/content/dam/edam/applecare/images/en_US/macbookpro/macos-sierra-macbook-pro-thunderbolt3-hero.jpg"
      )

      visit items_path
      expect(page).to have_content("computer")

      click_button "Add to Cart"
      click_button "Add to Cart"

      expect(page).to have_content("You have 2 computers in your cart.")
    end    

    it "total number of items in cart increments in nav bar" do
      category = Category.create(name: "Tech")
      category.items = Item.create(name: "computer",
                                  desc: "makes a rock think",
                                  price: 300,
                                  status: 0,
                                  photo: "https://support.apple.com/library/content/dam/edam/applecare/images/en_US/macbookpro/macos-sierra-macbook-pro-thunderbolt3-hero.jpg"
      )

      visit items_path
      expect(page).to have_content("computer")

      click_button "Add to Cart"
      click_button "Add to Cart"

      expect(page).to have_content("Cart: 2")
    end   
  end
  
end




When I visit any page with an item on it
I should see a link or button for "Add to Cart"
When I click "Add to cart" for that item
And I click a link or button to view cart
And my current path should be "/cart"
And I should see a small image, title, description and price for the item I just added
And there should be a "total" price for the cart that should be the sum of all items in the cart