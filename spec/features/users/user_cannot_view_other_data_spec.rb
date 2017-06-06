require 'rails_helper'

RSpec.feature 'User security' do
  context 'as an authenticated user' do
    let(:user) { create(:user) }
    let(:user_2) { create(:user, first_name: "Second") }

    scenario 'I cannot view other users\' order data' do
      user_order = create(:order, user: user)
      user_2_order = create(:order, user: user_2)
      user_order.items << create_list(:item, 2)
      user_2_order.items << create_list(:item, 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit orders_path

      expect(page).to have_content full_name(user)
      expect(page).to have_content "Order #{user_order.id}"
      expect(page).to have_content user_order.items.first.name
      expect(page).to have_content user_order.items.first.price
      expect(page).to have_content user_order.items.last.name
      expect(page).to have_content user_order.items.last.name

      expect(page).not_to have_content full_name(user_2)
      expect(page).not_to have_content "Order #{user_2_order.id}"
      expect(page).not_to have_content user_2_order.items.first.name
    end

    scenario 'I cannot view admin screens' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_dashboard_path

      expect(page).to have_content 'The page you were looking for doesn\'t exist.'
    end

    scenario 'I cannot become an admin'
  end

  context 'as an unauthenticated user' do
    scenario 'I cannot view past order data' do
      visit orders_path

      expect(page).to have_content 'Login'
      expect(page).to have_content 'You must be logged in to access this page.'
    end

    scenario 'I cannot view user dashboard' do
      visit dashboard_path

      expect(page).to have_content 'Login'
      expect(page).to have_content 'You must be logged in to access this page.'
    end

    scenario 'I cannot view admin screens' do
      visit admin_dashboard_path

      expect(page).to have_content 'The page you were looking for doesn\'t exist.'

      visit admin_items_path

      expect(page).to have_content 'The page you were looking for doesn\'t exist.'
    end

    scenario 'I cannot become an admin'
  end
end
