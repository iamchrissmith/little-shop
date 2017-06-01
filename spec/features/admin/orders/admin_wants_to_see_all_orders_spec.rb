require 'rails_helper'

RSpec.descibe 'Admin wants to see all orders' do

  before do
    @orders = create_list(:order, 3)
    @orders << create_list(:order, 3, :as_paid)
    @orders << create_list(:order, 3, :as_cancelled)
    @orders << create_list(:order, 3, :as_completed)

    @admin = create(:user, :as_admin)

    allow_any_instance_of(ApplicationController).to recieve(:current_user).and_return(admin)
  end

  scenario 'and sees all orders' do
    visit(admin_dashboard_path(@admin))

    within(page.find('orders-view')) do
      Order.all do |order|
        expect(page).to have_content(order.id)
      end
    end
  end

  scenario 'and sees total counts for each order status' do
    visit(admin_dashboard_path(@admin))

    it 'sees all ordered orders' do
      within(page.find('div', text: 'Ordered')) do
        expect(page).to have_content(Order.all_ordered.count)

        click_link 'Filter'
      end

      within(page.find('orders-view')) do
        Order.all_ordered.each do |order|
          expect(page).to have_content(order.id)
        end

        Order.all_paid.each do |order|
          expect(page).to_not have_content(order.id)
        end

        Order.all_cancelled.each do |order|
          expect(page).to_not have_content(order.id)
        end

        Order.all_completed.each do |order|
          expect(page).to_not have_content(order.id)
        end
      end
    end

    it 'sees all paid orders' do
      within(page.find('div', text: 'Paid')) do
        expect(page).to have_content(Order.all_paid.count)

        click_link 'Filter'
      end


      within(page.find('orders-view')) do
        Order.all_paid.each do |order|
          expect(page).to have_content(order.id)
        end

        Order.all_ordered.each do |order|
          expect(page).to_not have_content(order.id)
        end

        Order.all_cancelled.each do |order|
          expect(page).to_not have_content(order.id)
        end

        Order.all_completed.each do |order|
          expect(page).to_not have_content(order.id)
        end
      end
    end

    it 'sees all cancelled orders' do
      within(page.find('div', text: 'Cancelled')) do
        expect(page).to have_content(Order.all_cancelled.count)

        click_link 'Filter'
      end

      within(page.find('orders-view')) do
        Order.all_cancelled.each do |order|
          expect(page).to have_content(order.id)
        end

        Order.all_ordered.each do |order|
          expect(page).to_not have_content(order.id)
        end

        Order.all_paid.each do |order|
          expect(page).to_not have_content(order.id)
        end

        Order.all_completed.each do |order|
          expect(page).to_not have_content(order.id)
        end
      end
    end

    it 'sees all completed orders' do
      within(page.find('div', text: 'Completed')) do
        expect(page).to have_content(Order.all_completed.count)

        click_link 'Filter'
      end

      within(page.find('orders-view')) do
        Order.all_completed.each do |order|
          expect(page).to have_content(order.id)
        end

        Order.all_ordered.each do |order|
          expect(page).to_not have_content(order.id)
        end

        Order.all_paid.each do |order|
          expect(page).to_not have_content(order.id)
        end

        Order.all_cancelled.each do |order|
          expect(page).to_not have_content(order.id)
        end
      end
    end
  end
end

# Still to be added

# And I have links to transition between statuses
#
# I can click on "cancel" on individual orders which are "paid" or "ordered"
# I can click on "mark as paid" on orders that are "ordered"
# I can click on "mark as completed" on orders that are "paid"

