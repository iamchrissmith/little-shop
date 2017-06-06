require 'rails_helper'

RSpec.feature 'Logged In User can View Past Orders' do
  let(:user) { create(:user) }
  scenario 'a visitor can view past orders' do
    user.orders << create_list(:order, 3, :with_items)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit orders_path

    expect(page).to have_content(full_name(user))
    expect(page).to have_content('Your purchases')
    expect(page).to have_content(user.orders[0].id)
    expect(page).to have_content(user.orders[1].id)
    expect(page).to have_content(user.orders[2].id)

    click_link user.orders[0].id

    expect(current_path).to eq("/orders/#{user.orders[0].id}")
    expect(page).to have_content("Order #{user.orders[0].id}")
    expect(page).to have_content("Placed at: #{user.orders[0].created_at.to_s(:long)}")
    user.orders[0].items.each do |item|
      within(".item-#{item.id}") do
        expect(page).to have_link item.name, href: item_path(item)
        expect(page).to have_content item.description
        expect(page).to have_content item.price
        expect(page).to have_content '1'
      end
    end
  end

  context "when an order is completed" do
    scenario 'a visitor can see the completed time' do
      user.orders << create_list(:order, 3, :with_items)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      user.orders[0].completed!

      visit order_path(user.orders[0])

      expect(page).to have_content("Order #{user.orders[0].id}")
      expect(page).to have_content("Order Status: Completed")
      expect(page).to have_content("(at #{user.orders[0].updated_at.to_s(:long)})")
      expect(page).to have_content("Placed at: #{user.orders[0].created_at.to_s(:long)}")
    end
  end

  context "when an order is cancelled" do
    scenario 'a visitor can see the cancelled time' do
      user.orders << create_list(:order, 3, :with_items)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      user.orders[0].cancelled!

      visit order_path(user.orders[0])

      expect(page).to have_content("Order #{user.orders[0].id}")
      expect(page).to have_content("Order Status: Cancelled")
      expect(page).to have_content("(at #{user.orders[0].updated_at.to_s(:long)})")
      expect(page).to have_content("Placed at: #{user.orders[0].created_at.to_s(:long)}")
    end
  end
end
