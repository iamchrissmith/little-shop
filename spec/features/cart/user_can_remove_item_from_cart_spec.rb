require 'rails_helper'

RSpec.feature "Visitor can remove an item in the cart" do
  scenario "a visitor sees and removes an item from the cart" do
    # item = Item.create!(name: "700x42c tube",
    #     description: "Presta valve 700x42c Bicyle Inner Tube",
    #     price: 11.99, status: 0)
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
end
