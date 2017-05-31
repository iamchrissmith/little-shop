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

      click_link "computer"
      expect(page).to have_content("computer")

      click_button "Add to Cart"
      expect(page).to have_content("You added 1 computer to your cart.")
    end

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
      
      within "header nav" do
        expect(page).to have_content("Cart: 2")
      end
    end   

    it "total number of items in cart increments in view cart page" do
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
      
      within "header nav" do
        expect(page).to have_content("Cart: 2")
        click_link ("Cart: 2")
      end

      expect(current_path).to eq "/cart"
      expect(page).to have_css("img[src*='https://support.apple.com/library/content/dam/edam/applecare/images/en_US/macbookpro/macos-sierra-macbook-pro-thunderbolt3-hero.jpg']")
      expect(page).to have_content("computer")
      expect(page).to have_content("makes a rock think")
      expect(page).to have_content("$300")
      expect(page).to have_content("Total: $600")

    end  
  end
  
end