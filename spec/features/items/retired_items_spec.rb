require 'rails_helper'

RSpec.feature "User can see retired items" do
  let! (:item) = create(:item, :is_retired)
  context "as a user" #do
    xscenario "it can view a retired item" do

      visit item_path(item)

      expect(current_path).to eq(item_path(item))
      expect(page).to not_have_content("Add to Cart")
      expect(page).to have_content("Item Retired")

    end
  end
end
