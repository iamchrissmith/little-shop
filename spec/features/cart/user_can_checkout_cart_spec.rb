require 'rails_helper'
=begin
Background: An existing user and a cart with items

As a visitor
When I add items to my cart
And I visit "/cart"
And I click "Login or Register to Checkout"
Then I should be required to login

When I am logged in
And I visit my cart
And when I click "Checkout"
Then the order should be placed
And my current page should be "/orders"
And I should see a message "Order was successfully placed"
And I should see the order I just placed in a table
=end
RSpec.feature "User can checkout with cart" #do
  scenario "an existing user and cart with items" #do
    let! (:order) = create(:order)
    context "as a visitor" #do
      let! (:user) = create(:user, :visitor)
      visit cart_path
      click_on("Login or Register to Checkout")
      expect(current_path).to eq(login_path)
    #end

    context "as a registered user" #do
      let! (:user) = create(:user)

      visit cart_path
      click_on("Checkout")

      expect(current_path).to eq('/orders')
      # And I should see the order I just placed in a table

    #end
  #end
#end
