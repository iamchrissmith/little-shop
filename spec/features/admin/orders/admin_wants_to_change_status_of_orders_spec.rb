require 'rails_helper'

RSpec.describe 'Admin wants to change status of orders' do
  let(:admin) { create(:user, role: 'admin') }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  end

  describe "cancelling an order" do
    context "when order is 'ordered'" do
      scenario 'order can be cancelled' do
        order = create(:order)

        visit(admin_dashboard_path(admin))

        within("#all .order-#{order.id}") do
          expect(page).to have_select('order_status', :selected => 'Ordered')
          expect(page).to have_select('order_status', :options => ['Ordered', 'Paid', 'Cancelled'])

          select 'Cancelled', from: 'order_status'
          click_on 'Update'
        end
        within("#all .order-#{order.id}") do
          expect(page).not_to have_select('order_status')
          expect(page).to have_content 'Cancelled'
        end
      end
    end

    context "when order is 'paid'" do
      scenario 'order can be cancelled' do
        order = create(:order, status: 'paid')

        visit(admin_dashboard_path(admin))

        within("#all .order-#{order.id}") do
          expect(page).to have_select('order_status', :selected => 'Paid')
          expect(page).to have_select('order_status', :options => ['Paid', 'Completed', 'Cancelled'])

          select 'Cancelled', from: 'order_status'
          click_on 'Update'
        end
        within("#all .order-#{order.id}") do
          expect(page).not_to have_select('order_status')
          expect(page).to have_content 'Cancelled'
        end
      end
    end
  end

  context "when order is 'ordered'" do
    scenario 'order can be paid' do
      order = create(:order)

      visit(admin_dashboard_path(admin))

      within("#all .order-#{order.id}") do
        expect(page).to have_select('order_status', :selected => 'Ordered')
        expect(page).to have_select('order_status', :options => ['Ordered', 'Paid', 'Cancelled'])

        select 'Paid', from: 'order_status'
        click_on 'Update'
      end
      within("#all .order-#{order.id}") do
        expect(page).to have_select('order_status', :selected => 'Paid')
        expect(page).to have_content 'Paid'
      end
    end
  end

  context "when order is 'paid'" do
    scenario 'order can be completed' do
      order = create(:order, status: 'paid')

      visit(admin_dashboard_path(admin))

      within("#all .order-#{order.id}") do
        expect(page).to have_select('order_status', :selected => 'Paid')
        expect(page).to have_select('order_status', :options => ['Paid', 'Completed', 'Cancelled'])

        select 'Completed', from: 'order_status'
        click_on 'Update'
      end
      within("#all .order-#{order.id}") do
        expect(page).not_to have_select('order_status')
        expect(page).to have_content 'Completed'
      end
    end
  end

  context "when order is 'cancelled'" do
    scenario 'order status cannot be changed' do
      order = create(:order, status: 'cancelled')

      visit(admin_dashboard_path(admin))

      within("#all .order-#{order.id}") do
        expect(page).to have_content 'Cancelled'
        expect(page).not_to have_select('order_status')
      end
    end
  end

  context "when order is 'completed'" do
    scenario 'order status cannot be changed' do
      order = create(:order, status: 'completed')

      visit(admin_dashboard_path(admin))

      within("#all .order-#{order.id}") do
        expect(page).to have_content 'Completed'
        expect(page).not_to have_select('order_status')
      end
    end
  end
end
