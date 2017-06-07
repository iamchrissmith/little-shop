require 'rails_helper'

RSpec.feature 'Logged In User can View Past Orders' do
  let(:item_1) { create(:item) }
  let(:item_2) { create(:item, price: 100) }
  let(:user) { create(:user) }
  let!(:state) { create(:state) }

  context "when visit (not logged in) views /order" do
    scenario "the user is redirected to a login page" do
      visit orders_path

      expect(page).to have_content 'Login'
      expect(page).to have_content 'You must be logged in to access this page.'
    end
  end

  context "when the user is logged in and has previous orders" do
    let!(:previous_order) { create(:order, user: user, items: [item_1, item_2, item_2, item_2]) }
    let!(:current_order) { create(:order, user: user, items: [item_1, item_1, item_2]) }

    scenario "the user can see both orders on /orders" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      previous_order.completed!

      visit orders_path
      expect(page).to have_content 'Your purchases'

      expect(page).to have_content 'Your information'
      expect(page).to have_content full_name(user)
      expect(page).to have_content user.email

      expect(page).to have_css(".order-#{current_order.id}.well-lg")

      within(".order-#{current_order.id}") do
        expect(page).to have_content "Order Status: #{current_order.status}"
        within(".item-#{item_1.id}") do
          expect(page).to have_content item_1.name
          expect(page).to have_content item_1.description
          expect(page).to have_content item_1.price
          expect(page).to have_content('2')
        end
        within(".item-#{item_2.id}") do
          expect(page).to have_content item_2.name
          expect(page).to have_content item_2.description
          expect(page).to have_content item_2.price
          expect(page).to have_content('1')
        end
        expect(page).to have_content("Total: $#{current_order.total_price}")
      end

      within(".order-#{previous_order.id}") do
        expect(page).to have_content "Order Status: completed"
        within(".item-#{item_1.id}") do
          expect(page).to have_content item_1.name
          expect(page).to have_content item_1.description
          expect(page).to have_content item_1.price
          expect(page).to have_content('1')
        end
        within(".item-#{item_2.id}") do
          expect(page).to have_content item_2.name
          expect(page).to have_content item_2.description
          expect(page).to have_content item_2.price
          expect(page).to have_content('3')
        end
        expect(page).to have_content("Total: $#{previous_order.total_price}")
      end
    end
  end
end
