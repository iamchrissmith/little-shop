require 'rails_helper'

RSpec.describe 'Admin wants to change status of orders' do

  before do
    @admin = create(:user, :as_admin)

    allow_any_instance_of(ApplicationController).to recieve(:current_user).and_return(admin)
    visit(admin_dashboard_path(@admin))
  end

  xscenario 'cancel an order' do

    it 'can cancel an ordered order' do
      order = create(:order)

      within(find('div', text: order.id)) do
        expect(page).to have_select(dropdown, :selected => 'Ordered')
        expect(page).to have_select(dropdown, :options => ['Paid', 'Completed', 'Cancelled'])

        select 'Cancel', from: 'status'
        click_on 'Update'

        expect(page).to have_select(dropdown, :selected => 'Cancelled')
      end
    end

    it 'can cancel a paid order' do
      order = create(:order, :as_paid)

      within(find('div', text: order.id)) do
        expect(page).to have_select(dropdown, :selected => 'Paid')
        expect(page).to have_select(dropdown, :options => ['Completed', 'Cancelled'])

        select 'Cancelled', from: 'status'
        click_on 'Update'

        expect(page).to have_select(dropdown, :selected => 'Cancelled')
      end
    end

    it 'cannot cancel a completed order' do
      order = create(:order, :as_compeleted)

      within(find('div', text: order.id)) do
        expect(page).to have_select(dropdown, :selected => 'Completed')
        expect(page).to_not have_select(dropdown, :options => ['Ordered', 'Paid', 'Cancelled'])
      end
    end
  end

  xscenario 'mark as paid' do

    it 'can mark ordered as paid' do
      order = create(:order)

      within(find('div', text: order.id)) do
        expect(page).to have_select(dropdown, :selected => 'Ordered')
        expect(page).to have_select(dropdown, :options => ['Paid', 'Completed', 'Cancelled'])

        select 'Paid', from: 'status'
        click_on 'Update'

        expect(page).to have_select(dropdown, :selected => 'Paid')
      end
    end

    it 'cannot mark cancelled as paid' do
      order = create(:order, :as_cancelled)

      within(find('div', text: order.id)) do
        expect(page).to have_select(dropdown, :selected => 'Cancelled')
        expect(page).to_not have_select(dropdown, :options => ['Ordered', 'Paid', 'Completed'])
      end
    end

    it 'cannot mark completed as paid' do
      order = create(:order, :as_completed)

      within(find('div', text: order.id)) do
        expect(page).to have_select(dropdown, :selected => 'Completed')
        expect(page).to_not have_select(dropdown, :options => ['Ordered', 'Paid', 'Cancelled'])
      end
    end
  end

  xscenario 'mark as completed' do

    it 'can mark paid as completed' do
      order = create(:order, :as_paid)

      within(find('div', text: order.id)) do
        expect(page).to have_select(dropdown, :selected => 'Paid')
        expect(page).to have_select(dropdown, :options => ['Completed', 'Cancelled'])

        select 'Completed', from: 'status'
        click_on 'Update'

        expect(page).to have_select(dropdown, :selected => 'Completed')
      end
    end

    it 'cannot mark ordered completed' do
      order = create(:order)

      within(find('div', text: order.id)) do
        expect(page).to have_select(dropdown, :selected => 'Ordered')
        expect(page).to_not have_select(dropdown, :options => ['Completed'])
      end
    end

    it 'cannot mark cancelled as completed' do
      order = create(:order, :as_cancelled)

      within(find('div', text: order.id)) do
        expect(page).to have_select(dropdown, :selected => 'Cancelled')
        expect(page).to_not have_select(dropdown, :options => ['Ordered', 'Paid', 'Completed'])
      end
    end
  end
end