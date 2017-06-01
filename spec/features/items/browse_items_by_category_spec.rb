require 'rails_helper'

RSpec.feature "user can browse items by category" do
  it "user can visit category and browse items belonging to that category" do
    item1 = create(:item, category: "Garden")
    item2 = create(:item, category: "Garden")
    item3 = create(:item, category: "Tech")
    item4 = create(:item, category: "Tech")
    # are the two above, different?

    visit items_path
    expect(page).to have_content(item1.name)
    expect(page).to have_content(item2.name)
    expect(page).to have_content(item3.name)
    expect(page).to have_content(item4.name)


    within "header nav" do
      click_link "Categories"
      click_link "Tech"
    end

    expect(page).to have_content(item3.name)
    expect(page).to have_content(item4.name)
    expect(page).to_not have_content(item1.name)
    expect(page).to_not have_content(item2.name)
  end
end