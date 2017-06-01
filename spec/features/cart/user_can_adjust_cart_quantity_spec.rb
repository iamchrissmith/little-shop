require 'rails_helper'
=begin
As a visitor
When I visit "/cart"
Then I should see my item with a quantity of 1
And when I increase the quantity
Then my current page should be '/cart'
And that item's quantity should reflect the increase
And the subtotal for that item should increase
And the total for the cart should match that increase
=end
RSpec.feature "Visitor can adjust cart quantity" do
  scenario "a visitor can change quantity of an item in their cart" do
    item = Item.create!(name: "700x42c tube",
        description: "Presta valve 700x42c Bicyle Inner Tube",
        price: 11.99, status: 1)
    order = Order.create!()

    visit cart_path

    expect(page).to have_content(item.name)
<<<<<<< HEAD
    expect(page).to have_content(order.item.quantity)
=======
    expect(page).to have_content(order.quantity)
>>>>>>> cart_item_removal

    #select_quantity_increase
    click_on("Update Cart")

    expect(current_path).to eq(cart_path)
<<<<<<< HEAD
    expect(page).to have_content(order.item.quantity + 1)
    expect(page).to have_content(order.quantity + 1)


=======
    
>>>>>>> cart_item_removal


  end
end
