require 'rails_helper'

RSpec.describe 'Admin wants to view an item' do

  before do
    @items = create_list(:item, 3)
    @admin = create(:user, role: 'admin')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    visit admin_dashboard_path
  end

  scenario 'admin can see all items' do
    click_link 'Items'

    expect(page).to have_current_path(admin_items_path)

    @items.each do |item|
      within(page.find(".item-#{item.id}")) do
        expect(page).to have_link(item.name)
        expect(page).to have_content(item.status)
        expect(page).to have_link('Edit', href: edit_admin_item_path(item))
      end
    end
  end

  scenario 'admin can visit an item' do
    click_link 'Items'
    item = Item.all[2]

    within(page.find(".item-#{item.id}")) do
      click_link "#{item.name}"
    end

    expect(page).to have_content(item.name)
    expect(page).to have_content(item.description)
    expect(page).to have_content(item.price)
    expect(page).to have_content(item.status)
    expect(page).to have_link('Edit', href: edit_admin_item_path(item))
  end
end
