require 'rails_helper'

RSpec.feature "Visitor can remove an item in the cart" do
  xscenario "a visitor see the cart page that contains items" do
    # item = Item.create!(name: "700x42c tube",
    #     description: "Presta valve 700x42c Bicyle Inner Tube",
    #     price: 11.99, status: 0)
    let! (:item) { create(:item) }

    visit cart_path
    click_on "Remove"

    expect(current_path).to eq("/cart")
    expect(page).to have_css(".alert-success", text: "Successfully removed #{item.name} from your cart")
    expect(page).to have_link("#{item.name}", item_path(item))
    expect(page).to_not have_content("#{item.name}")
  end
end
