require 'rails_helper'

RSpec.feature "User can checkout with cart" #do
  xscenario "an existing user and cart with items" #do
    let! (:order) = create(:order)
    context "as a visitor" #do
      let! (:user) = create(:user, :visitor)
      visit cart_path
      click_on("Login or Register to Checkout")
      expect(current_path).to eq(login_path)
    #end

    context "as a registered user with items in the cart" #do
      let! (:user) = create(:user)
      let! (:order) = create(:order)

      visit cart_path
      click_on("Checkout")
      expect(order.status).to eq("completed")
      expect(current_path).to eq('/orders')
      expect(page).to have_content("Order was successfully placed")
      expect(page).to have_css('table')
    #end
  #end
#end
