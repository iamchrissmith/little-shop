require 'rails_helper'

RSpec.feature "User can checkout with cart" do
  let(:item) { create(:item) }
  let(:user) { create(:user) }
  let!(:state) { create(:state) }
  let!(:address) { create(:address) }

  context "when the user is logged in" do
    scenario "the user can checkout" do
      cart = build(:cart, contents: { item.id.to_s => 1 })
      cart = cart = build(:cart, contents: { item.id.to_s => 1 })
      allow_any_instance_of(ApplicationController).to receive(:current_cart).and_return(cart)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit cart_path

      within(".item-#{item.id}") do
        expect(page).to have_content('Quantity: ')
        expect(page).to have_selector('input[value="1"]')
      end
      expect(page).to have_content("Total: $#{item.price}")

      click_on("Checkout")

      expect(current_path).to eq new_order_path
      expect(page).to have_content "Checkout"
      within(".item-#{item.id}") do
        expect(page).to have_content item.name
        expect(page).to have_content item.description
        expect(page).to have_content item.price
        expect(page).to have_content('1')
      end
      expect(page).to have_content("Total: $#{item.price}")

      # expect(page).to have_css('order[address][address]', visible: false)
      # expect(page).to have_css('order[address][zipcode]', visible: false)
      # fill_in 'Address', with: '123 Street Ave'
      # fill_in 'City', with: 'Somewhere'
      # select state.abbr, from: 'user[address][city][state_id]'
      # fill_in 'Zipcode', with: '12345'
      # select 'Shipping', from: 'address_type'

      click_on "Complete Order"

      expect(current_path).to eq('/orders')
      expect(page).to have_content 'Order was successfully placed'
      expect(page).to have_content 'Your purchase'
      expect(page).to have_content 'Order Status: ordered'
      expect(page).to have_content item.name
      expect(page).to have_content item.description
      # expect(page).to have_content "Total: $#{item.price}"
      expect(page).to have_content 'Quantity: 1'
      expect(page).to have_content 'Your information'
      expect(page).to have_content fullname(user)
      expect(page).to have_content user.email
      # expect(page).to have_content '123 Street Ave'
      # expect(page).to have_content 'Somewhere'
      # expect(page).to have_content '12345'
      # expect(page).to have_content 'CO'
    end
  end
end
