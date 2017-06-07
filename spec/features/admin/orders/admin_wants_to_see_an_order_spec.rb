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
    expect(page).to have_select('order_status', :selected => @order.status.capitalize)
    expect(page).to have_select('order_status', :options => ['Ordered', 'Paid', 'Cancelled'])
    
    select 'Paid', from: 'order_status'
    click_on 'Update'

    expect(page).to have_select('order_status', :selected => 'Paid')

    @order.order_items.each do |order_item|
      expect(page).to have_link(order_item.item.name, href: "/items/#{item.id}" )
      expect(page).to have_content(order_item.quantity)
      expect(page).to have_content(order_item.item.price)
      expect(page).to have_content(order_item.sub_total)
    end
  end
end
