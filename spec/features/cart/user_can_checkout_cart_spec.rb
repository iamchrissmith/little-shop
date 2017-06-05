require 'rails_helper'

RSpec.feature "User can checkout with cart" do
  let(:item_1) { create(:item) }
  let(:item_2) { create(:item, price: 100) }
  let(:user) { create(:user) }
  let!(:state) { create(:state) }
  # let!(:address) { create(:address) }

  context "when the user is logged in" do
    scenario "the user can checkout" do
      cart = build(:cart, contents: {
        item_1.id.to_s => 2,
        item_2.id.to_s => 1,
      })
      allow_any_instance_of(ApplicationController).to receive(:current_cart).and_return(cart)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit cart_path

      within(".item-#{item_1.id}") do
        expect(page).to have_content('Quantity: ')
        expect(page).to have_selector('input[value="2"]')
      end
      within(".item-#{item_2.id}") do
        expect(page).to have_content('Quantity: ')
        expect(page).to have_selector('input[value="1"]')
      end
      total = (item_1.price * 2) + item_2.price
      expect(page).to have_content("Total: $#{total = (item_1.price * 2) + item_2.price}")

      click_on("Checkout")

      expect(current_path).to eq new_order_path
      expect(page).to have_content "Checkout"
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
      expect(page).to have_content("Total: $#{total}")

      fill_in 'Address', with: '123 Street Ave'
      fill_in 'City', with: 'Somewhere'
      select state.abbr, from: 'order[address_attributes][city_attributes][state_id]'
      fill_in 'Zipcode', with: '12345'
      # select 'Shipping', from: 'address_type'

      click_on "Complete Order"

      expect(current_path).to eq('/orders')
      expect(page).to have_content 'Order was successfully placed'
      expect(page).to have_content 'Your purchases'
      expect(page).to have_content 'Order Status: ordered'
      expect(page).to have_content 'Your information'
      expect(page).to have_content full_name(user)
      expect(page).to have_content user.email
      expect(page).to have_content '123 Street Ave'
      expect(page).to have_content 'Somewhere'
      expect(page).to have_content '12345'
      expect(page).to have_content 'CO'

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

      expect(page).to have_content("Total: $#{total}")
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
