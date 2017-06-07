require 'rails_helper'

RSpec.feature "user can browse items by category" do
  let!(:item_1) { create(:item) }
  let!(:item_2) { create(:item) }

  it "user can visit category and browse items belonging to that category" do

    visit items_path
    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_2.name)

    within "header nav" do
      click_link "Categories"
      click_link item_1.categories[0].name
    end

    expect(current_path).to eq("/categories/#{item_1.categories[0].slug}")
    expect(page).to have_content(item_1.name)
    expect(page).to_not have_content(item_2.name)
  end
end
