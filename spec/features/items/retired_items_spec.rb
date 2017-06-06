require 'rails_helper'

RSpec.feature "User can see retired items" do
  let! (:item) { create(:item, status: 'retired') }
  context "as a user" do
    scenario "it can view a retired item" do

      visit item_path(item)

      expect(current_path).to eq(item_path(item))
      expect(page).not_to have_content("Add to Cart")
      expect(page).to have_content("Item Retired")

    end
  end
end
