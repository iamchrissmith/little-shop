require 'rails_helper'

RSpec.feature "Visitor can adjust cart quantity" do
  scenario "a visitor can change quantity of an item in their cart" do
    # item = Item.create!(name: "700x42c tube",
    #     description: "Presta valve 700x42c Bicyle Inner Tube",
    #     price: 11.99, status: 1)
    # order = Order.create!()
    let! (:order) = create(:order)

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
end
