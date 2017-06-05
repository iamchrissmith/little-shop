require 'rails_helper'

RSpec.describe 'Admin want to create and item' do

  before do
    @admin = create(:user, role: 'admin')
    @categories = create_list(:category, 3)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  describe 'admin creates valid item' do
    it 'creates item' do
      visit new_admin_item_path
      expect(Item.count).to eq(0)

      within 'form' do
        fill_in 'Name', with: 'Widget'
        fill_in 'Description', with: 'It bing bong bangs!'
        fill_in 'Price', with: '3.5'
        find_by_id("item_category_ids_#{@categories[1].id}").set(true)

        click_on 'Create Item'
      end

      expect(Item.count).to eq(1)
      expect(page).to have_current_path(admin_items_path)
      expect(page).to have_content("Item #{Item.last.id} Created")
    end
  end

  describe 'admin creates invalid item' do

    it 'does not enter a name' do
      visit new_admin_item_path
      expect(Item.count).to eq(0)

      within 'form' do
        fill_in 'Name', with: ''
        fill_in 'Description', with: 'It bing bong bangs!'
        fill_in 'Price', with: '3.5'
        find_by_id("item_category_ids_#{@categories[1].id}").set(true)

        click_on 'Create Item'
      end

      expect(Item.count).to eq(0)
      expect(page).to have_content("Name can't be blank")
    end

    it 'does not enter a unique name' do
      create(:item, name: 'Widget')
      visit new_admin_item_path

      within 'form' do
        fill_in 'Name', with: 'Widget'
        fill_in 'Description', with: 'It bing bong bangs!'
        fill_in 'Price', with: '3.5'
        find_by_id("item_category_ids_#{@categories[1].id}").set(true)

        click_on 'Create Item'
      end

      expect(Item.count).to eq(1)
      expect(page).to have_content('Name has already been taken')
    end

    it 'does not enter a description' do
      visit new_admin_item_path

      within 'form' do
        fill_in 'Name', with: 'Widget'
        fill_in 'Description', with: ''
        fill_in 'Price', with: '3.5'
        find_by_id("item_category_ids_#{@categories[1].id}").set(true)

        click_on 'Create Item'
      end

      expect(Item.count).to eq(0)
      expect(page).to have_content("Description can't be blank")
    end

    it 'does not enter a price' do
      visit new_admin_item_path

      within 'form' do
        fill_in 'Name', with: 'Widget'
        fill_in 'Description', with: 'It bing bong bangs!'
        fill_in 'Price', with: ''
        find_by_id("item_category_ids_#{@categories[1].id}").set(true)

        click_on 'Create Item'
      end

      expect(Item.count).to eq(0)
      expect(page).to have_content("Price can't be blank")
    end

    it 'does not enter a valid price' do
      visit new_admin_item_path

      within 'form' do
        fill_in 'Name', with: 'Widget'
        fill_in 'Description', with: 'It bing bong bangs!'
        fill_in 'Price', with: 'three fiddy'
        find_by_id("item_category_ids_#{@categories[1].id}").set(true)

        click_on 'Create Item'
      end

      expect(Item.count).to eq(0)
      expect(page).to have_content("Price is not a number")
    end

    it 'does not enter at least one category' do
      visit new_admin_item_path

      within 'form' do
        fill_in 'Name', with: 'Widget'
        fill_in 'Description', with: 'It bing bong bangs!'
        fill_in 'Price', with: '3.5'

        click_on 'Create Item'
      end

      expect(Item.count).to eq(0)
      expect(page).to have_content("Categories can't be blank")
    end

  end
end
