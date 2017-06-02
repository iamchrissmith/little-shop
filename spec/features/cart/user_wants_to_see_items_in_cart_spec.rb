require 'rails_helper'

RSpec.describe "User wants to see items in cart" do

  before do
    @items = create_list(:item, 3)
    # @user = create(:user)
    visit(root_path)
    within(page.find('div', text: "#{@item[0].name}")) do
      2.times { click_on "Add to Cart" }
    end
  end

  xscenario "They see items in cart" do
    click_on('Cart')

    within(page.find('div', text: "#{@items[0].name}")) do
      expect(page).to have(1)
    end
  end

  xscenario "They lower an item quantity in cart" do
    click_on('Cart')
    within(page.find('div', text: "#{@items[0].name}")) do
      select '1', from: 'quantity'
    end

    within(page.find('div', text: "#{@items[0].name}")) do
      expect(page).to have(1)
    end
  end

end
