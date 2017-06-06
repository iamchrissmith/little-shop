require 'rails_helper'

RSpec.feature 'Logged In User can View Past Orders' do
  let(:user) { create(:user) }
  scenario 'a visitor can view past orders' do
    user.orders << create_list(:order, 3)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit orders_path

    expect(page).to have_content(full_name(user))
    expect(page).to have_content('Your purchases')
    expect(page).to have_content(user.orders[0].id)
    expect(page).to have_content(user.orders[1].id)
    expect(page).to have_content(user.orders[2].id)

    click_link user.orders[0].id

    expect(current_path).to eq("user/#{user.id}/orders/#{user.order[0].id}")
    expect(page).to have_content("Order: #{user.order[0].id}")

    #how to check for listed out items?
  end
end
