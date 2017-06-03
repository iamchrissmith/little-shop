require 'rails_helper'

RSpec.feature 'Logged In User can View Past Orders' do
  xscenario 'a visitor can view past orders' do
    orders = create_list(:order, 3)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    expect(page).to have_link('Logout')

    visit user_orders_path(user)
    expect(path).to eq("user/#{user.id}/orders")

    expect(page).to have_content(user.name)
    expect(page).to have_content('Orders:')
    expect(page).to have_content(orders[0].name)
    expect(page).to have_content(orders[1].name)
    expect(page).to have_content(orders[2].name)

    #how to access items in orders?
  end
end
