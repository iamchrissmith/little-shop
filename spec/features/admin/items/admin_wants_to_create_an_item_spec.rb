require 'rails_helper'

RSpec.describe 'Admin want to create and item' do

  before do
    @admin = create(:user, :as_admin)
    @categories = create_list(:category, 3)

    allow_any_instance_of(ApplicationController).to recieve(:current_user).and_return(admin)
    visit new_admin_item_path
  end

  scenario 'admin creates valid item' do
    expect(Item.count).to eq(0)

    within 'form' do
      fill_in 'Name' with('Widget')
      fill_in 'Description' with('It bing bong bangs!')
      fill_in 'Price' with('3.5')
      select @categories[1].name from 'categories'

      click_on 'Submit'
    end

    expect(Item.count).to eq(1)
    expect(page).to have_current_path(admin_item_path(Item.last))
    expect(page).to have_content('Item Created')
  end

  scenario 'admin creates invalid item' do

    it 'does not enter a name' do
      expect(Item.count).to eq(0)

      within 'form' do
        fill_in 'Name' with('')
        fill_in 'Description' with('It bing bong bangs!')
        fill_in 'Price' with('3.5')
        select @categories[1].name from 'categories'

        click_on 'Submit'
      end

      expect(Item.count).to eq(0)
      expect(page).to have_content('Name cannot be blank')
    end

    it 'does not enter a unique name' do
      create(:item, name: 'Widget')

      within 'form' do
        fill_in 'Name' with('Widget')
        fill_in 'Description' with('It bing bong bangs!')
        fill_in 'Price' with('3.5')
        select @categories[1].name from 'categories'

        click_on 'Submit'
      end

      expect(Item.count).to eq(0)
      expect(page).to have_content('Name Widget already in use')
    end

    it 'does not enter a description' do

      within 'form' do
        fill_in 'Name' with('Widget')
        fill_in 'Description' with('')
        fill_in 'Price' with('3.5')
        select @categories[1].name from 'categories'

        click_on 'Submit'
      end

      expect(Item.count).to eq(0)
      expect(page).to have_content('Description cannot be blank')
    end

    it 'does not enter a price' do
      within 'form' do
        fill_in 'Name' with('Widget')
        fill_in 'Description' with('It bing bong bangs!')
        fill_in 'Price' with('')
        select @categories[1].name from 'categories'

        click_on 'Submit'
      end

      expect(Item.count).to eq(0)
      expect(page).to have_content('Price cannot be blank')
    end

    it 'does not enter a valid price' do
      within 'form' do
        fill_in 'Name' with('Widget')
        fill_in 'Description' with('It bing bong bangs!')
        fill_in 'Price' with('three fiddy')
        select @categories[1].name from 'categories'

        click_on 'Submit'
      end

      expect(Item.count).to eq(0)
      expect(page).to have_content('Price must be a number') #This error might be different
    end

  end
