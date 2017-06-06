require 'rails_helper'

RSpec.describe 'Admin wants to see all orders' do

  before do
    @orders = create_list(:order, 3)
    @orders << create_list(:order, 3, :as_paid)
    @orders << create_list(:order, 3, :as_cancelled)
    @orders << create_list(:order, 3, :as_completed)

    @admin = create(:user, role: 'admin')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  scenario 'and sees all orders' do
    visit(admin_dashboard_path(@admin))

    Order.all do |order|
      expect(page).to have_content(order.id)
    end
  end

  scenario 'and sees total counts for each order status' do
    visit(admin_dashboard_path(@admin))

    expect(page).to have_content("All Orders (#{Order.all.count})")

    Order.all.each do |order|
      expect(page).to have_content(order.id)
    end
  end

  scenario 'sees all ordered orders' do
    visit(admin_dashboard_path(@admin))

    expect(page).to have_content("Ordered (#{Order.ordered.count})")

    within("div#ordered") do
      Order.cancelled.each do |order|
        expect(page).to_not have_css(".order-#{order.id}")
      end

      Order.ordered.each do |order|
        within(".order-#{order.id} .order-id") do
          expect(page).to have_content(order.id)
        end
      end

      Order.paid.each do |order|
        expect(page).to_not have_css(".order-#{order.id}")
      end

      Order.completed.each do |order|
        expect(page).to_not have_css(".order-#{order.id}")
      end
    end
  end

  scenario 'sees all paid orders' do
    visit(admin_dashboard_path(@admin))

    expect(page).to have_content("Paid (#{Order.paid.count})")

    within("div#paid") do
      Order.cancelled.each do |order|
        expect(page).to_not have_css(".order-#{order.id}")
      end

      Order.ordered.each do |order|
        expect(page).to_not have_css(".order-#{order.id}")
      end

      Order.paid.each do |order|
        within(".order-#{order.id} .order-id") do
          expect(page).to have_content(order.id)
        end
      end

      Order.completed.each do |order|
        expect(page).to_not have_css(".order-#{order.id}")
      end
    end
  end

  scenario 'sees all cancelled orders' do
    visit(admin_dashboard_path(@admin))

    expect(page).to have_content("Cancelled (#{Order.cancelled.count})")

    within("div#cancelled") do
      Order.cancelled.each do |order|
        within(".order-#{order.id} .order-id") do
          expect(page).to have_content(order.id)
        end
      end

      Order.ordered.each do |order|
        expect(page).to_not have_css(".order-#{order.id}")
      end

      Order.paid.each do |order|
        expect(page).to_not have_css(".order-#{order.id}")
      end

      Order.completed.each do |order|
        expect(page).to_not have_css(".order-#{order.id}")
      end
    end
  end

  scenario 'sees all completed orders' do
    visit(admin_dashboard_path(@admin))

    expect(page).to have_content("Completed (#{Order.completed.count})")

    within("div#completed") do
      Order.cancelled.each do |order|
        expect(page).to_not have_css(".order-#{order.id}")
      end

      Order.ordered.each do |order|
        expect(page).to_not have_css(".order-#{order.id}")
      end

      Order.paid.each do |order|
        expect(page).to_not have_css(".order-#{order.id}")
      end

      Order.completed.each do |order|
        within(".order-#{order.id} .order-id") do
          expect(page).to have_content(order.id)
        end
      end
    end
  end
end