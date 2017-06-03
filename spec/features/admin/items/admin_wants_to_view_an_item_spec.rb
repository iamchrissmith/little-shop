require 'rails_helper'

RSpec.describe 'Admin wants to view an item' do

  before do
    @items = create_list(:item, 3)
    @admin = create(:user, :as_admin)

    allow_any_instance_of(ApplicationController).to recieve(:current_user).and_return(admin)
    visit admin_dashboard_path(@admin)
  end

  xscenario 'admin can see items' do
    click_link 'View All Items'

    expect(page).to have_current_path(admin_items_path)

    @items.each do |item|
      expect(page).to have_link(@item.name)
      expect(page).to have_content(@item.description)
      expect(page).to have_content(@item.price)
      expect(page).to have_content(@item.status)
    end
  end
end
