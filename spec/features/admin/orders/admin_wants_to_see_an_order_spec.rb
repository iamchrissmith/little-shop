require 'rails_helper'

RSpec.describe 'Admin wants to see an order' do

  before do
    @admin = create(:user, role: 'admin')
    @order = create(:order)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    visit(admin_dashboard_path(@admin))
  end

  scenario 'admin visits order show page' do

    within("div#all .order-#{@order.id} .order-id") do
      click_link "#{@order.id}"
    end

    expect(page).to have_content(@order.created_at.to_date)
    expect(page).to have_content(@order.user.first_name)
    expect(page).to have_content(@order.address.address)
    expect(page).to have_content(@order.total_price)
    save_and_open_page
    expect(page).to have_select('order_status', :selected => @order.status)

    @order.item_orders.each do |item_order|
      expect(page).to have_link(item_order.item.name, href: "/items/#{item.id}" )
      expect(page).to have_content(item_order.quantity)
      expect(page).to have_content(item_order.item.price)
      expect(page).to have_content(item_order.sub_total)
    end
  end
end
