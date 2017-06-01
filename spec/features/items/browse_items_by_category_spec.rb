require 'rails_helper'

RSpec.feature "user can browse items by category" do
  it "user can visit category and browse items belonging to that category" do
    let!(:item_1) { create(:item, :with_many_categories) }
    let!(:item_2) { create(:item, :with_many_categories) }
    
    visit items_path
    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_2.name)
  


    within "header nav" do
      click_link "Categories"
      click_link item_1.categories[0].name
    end

    expect(page).to have_content(item_1.name)
    expect(page).to_not have_content(item_2.name)
  end
end
