require 'rails_helper'

RSpec.feature "user can add items to a cart" do
  context "as a guest user is not logged in" do
    it "user can add item to cart from items page" do
      item = create(:item)
      visit items_path
      expect(page).to have_content(item.name)

      click_button "Add to Cart"
      expect(page).to have_content("You now have 1 #{item.name} in your cart.")
      expect(page).to have_content("Cart: 1")

      click_button "Add to Cart"
      expect(page).to have_content("You now have 2 #{item.name}s in your cart.")
      expect(page).to have_content("Cart: 2")

      within "header nav" do
        expect(page).to have_content("Cart: 2")
        click_link ("Cart: 2")
      end

      # expect(current_path).to eq "/cart"
      expect(page).to have_current_path('/cart')
      #expect(page).to have_css("img[src*='https://support.apple.com/library/content/dam/edam/applecare/images/en_US/macbookpro/macos-sierra-macbook-pro-thunderbolt3-hero.jpg']")
      # (need to add image to Factory girl)
      expect(page).to have_content(item.name)
      expect(page).to have_content(item.description)
      expect(page).to have_content(item.price)
      expect(page).to have_content("Quantity: 2")
      expect(page).to have_content("Total: $#{item.price * 2}")

    end

    xit "user can add item to cart from item view page" do
      item = create(:item)

      visit item_path(:item)
      expect(page).to have_content(item.name)

      click_link item.name
      expect(page).to have_content(item.name)

      click_button "Add to Cart"
      expect(page).to have_content("You added 1 #{item.name} in your cart.")

      click_button "Add to Cart"
      expect(page).to have_content("You now have 2 #{item.name}s in your cart.")

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

    it "total number of particular item in cart increments" do
      item = create(:item)
      item_2 = create(:item)

      visit items_path
      expect(page).to have_content(item.name)
      expect(page).to have_content(item_2.name)


      within(:css, ".item-#{item.id}") do
        click_button "Add to Cart"
      end
      expect(page).to have_content("You now have 1 #{item.name} in your cart.")

      within(:css, ".item-#{item_2.id}") do
        click_button "Add to Cart"
        click_button "Add to Cart"
      end

      expect(page).to have_content("You now have 2 #{item_2.name}s in your cart.")

      within "header nav" do
        expect(page).to have_content("Cart: 3")
        click_link ("Cart: 3")
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

    it "total number of items in cart increments in nav bar" do
      item = create(:item)
      item_2 = create(:item)

      visit items_path
      expect(page).to have_content(item.name)
      expect(page).to have_content(item_2.name)

      within(:css, ".item-#{item.id}") do
        click_button "Add to Cart"
      end

      expect(page).to have_content("You now have 1 #{item.name} in your cart.")

      within(:css, ".item-#{item_2.id}") do
        click_button "Add to Cart"
        click_button "Add to Cart"
      end

      expect(page).to have_content("You now have 2 #{item_2.name}s in your cart.")

      within "header nav" do
        expect(page).to have_content("Cart: 3")
        click_link ("Cart: 3")
      end

      expect(current_path).to eq "/cart"
      #expect(page).to have_css("img[src*='https://support.apple.com/library/content/dam/edam/applecare/images/en_US/macbookpro/macos-sierra-macbook-pro-thunderbolt3-hero.jpg']")
      # (need to add image to Factory girl)
      expect(page).to have_content(item.name)
      expect(page).to have_content(item.description)
      expect(page).to have_content(item.price)
      expect(page).to have_content("Quantity: 1")
      expect(page).to have_content(item_2.name)
      expect(page).to have_content(item_2.description)
      expect(page).to have_content(item_2.price)
      expect(page).to have_content("Quantity: 2")
      expect(page).to have_content("Total: $#{((item.price * 1) + (item_2.price * 2))}")
    end

    xit "total number of items in cart increments in view cart page" do
      item = create(:item)
      item_2 = create(:item)


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
