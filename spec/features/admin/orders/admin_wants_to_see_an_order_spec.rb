require 'rails_helper'

RSpec.describe 'Admin wants to see an order' do

  before do
    @admin = create(:user, :as_admin)
    @order = create(:order, :with_user)

    allow_any_instance_of(ApplicationController).to recieve(:current_user).and_return(admin)
    visit(admin_dashboard_path(@admin))
  end

  xscenario 'admin visits order show page' do

    within(find('div', text: @order.id)) do
      click_link 'View Order'

      expect(page).to have_content(@order.date_created)
      expect(page).to have_content(@order.user.full_name)
      expect(page).to have_content(@order.user.address)
      expect(page).to have_content(@order.total)
      expect(page).to have_select(dropdown, :selected => @order.status)

      @order.item_orders.each do |item_order|
        expect(page).to have_link(item_order.item.name, href: "/items/#{item.id}" )
        expect(page).to have_content(item_order.quantity)
        expect(page).to have_content(item_order.item.price)
        expect(page).to have_content(item_order.sub_total)
      end
    end
  end
end
