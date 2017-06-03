require 'rails_helper'

RSpec.describe 'Admin want to edit and item' do

  before do
    @item = create_list(:item, 10)
    @admin = create(:user, role: 'admin')
    @categories = create_list(:category, 3)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    visit(admin_items_path)
  end


  describe 'admin visits an items edit page' do

    it 'sees the item with form filled in' do
      item = Item.all[4]

      within(page.find_by_id("item_#{item.id}")) do
        click_link 'Edit'
      end

      expect(find_field('Name').value).to eq("#{item.name}")
      expect(page).to have_content(item.description)
      expect(find_field('Price').value).to eq("#{item.price}")
      expect(page).to have_content(item.status)
      expect(page).to have_select('item_status', :selected => 'active')
      expect(page).to have_select('item_status', :options => ['active', 'retired'])
      item.categories.each do |cat|
        expect(find_by_id("item_category_ids_#{cat.id}")).to be_truthy
      end
    end
  end

  describe 'admin edits item' do

    it 'enters valid info' do
      item = Item.all[4]
      visit edit_admin_item_path(item)

      within 'form' do
        fill_in 'Name', with:'Widget'
        fill_in 'Description', with:'It bing bong bangs!'
        fill_in 'Price', with:'3.5'
        select 'retire', from: 'item_status'

        click_on 'Update Item'
      end

      expect(page).to have_current_path(admin_items_path)
      expect(page).to have_content("Item #{item.id} Updated")
    end
  end

  describe 'admin edits invalid item' do

    it 'does not enter a name' do
      item = Item.all[4]
      visit edit_admin_item_path(item)

      within 'form' do
        fill_in 'Name', with: ''
        fill_in 'Description', with: 'It bing bong bangs!'
        fill_in 'Price', with: '3.5'

        click_on 'Update Item'
      end

      expect(page).to have_content("Name can't be blank")
    end

    it 'does not enter a unique name' do
      create(:item, name: 'Widget')
      item = Item.all[4]
      visit edit_admin_item_path(item)

      within 'form' do
        fill_in 'Name', with:'Widget'
        fill_in 'Description', with:'It bing bong bangs!'
        fill_in 'Price', with:'3.5'

        click_on 'Update Item'
      end

      expect(page).to have_content("Name has already been taken")
    end

    it 'does not enter a description' do
      item = Item.all[4]
      visit edit_admin_item_path(item)

      within 'form' do
        fill_in 'Name', with:'Widget'
        fill_in 'Description', with:''
        fill_in 'Price', with:'3.5'

        click_on 'Update Item'
      end

      expect(page).to have_content("Description can't be blank")
    end

    it 'does not enter a price' do
      item = Item.all[4]
      visit edit_admin_item_path(item)

      within 'form' do
        fill_in 'Name', with:'Widget'
        fill_in 'Description', with:'It bing bong bangs!'
        fill_in 'Price', with:''

        click_on 'Update Item'
      end

      expect(page).to have_content("Price can't be blank")
    end

    it 'does not enter a valid price' do
      item = Item.all[4]
      visit edit_admin_item_path(item)

      within 'form' do
        fill_in 'Name', with:'Widget'
        fill_in 'Description', with:'It bing bong bangs!'
        fill_in 'Price', with:'three fiddy'

        click_on 'Update Item'
      end

      expect(page).to have_content('Price is not a number')
    end

    it 'does not enter at least one category' do
      item = Item.all[4]
      visit edit_admin_item_path(item)

      within 'form' do
        fill_in 'Name', with: 'Widget'
        fill_in 'Description', with: 'It bing bong bangs!'
        fill_in 'Price', with: '3.5'

        item.categories.each do |cat|
          find_by_id("item_category_ids_#{cat.id}").set(false)
        end

        click_on 'Update Item'
      end

      expect(page).to have_content("Categories can't be blank")
    end
  end
end