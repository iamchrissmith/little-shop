require 'rails_helper'

RSpec.describe OrderItem, type: :model do

  describe 'Validations' do
    it { should belong_to(:item) }
    it { should belong_to(:order) }
  end

  describe 'Factories' do

    it 'is an OrderItem' do
      expect(create(:order_item)).to be_a(OrderItem)
    end

    it 'has attributes' do
      order_item = create(:order_item)

      expect(order_item.item).to be_a(Item)
      expect(order_item.order).to be_a(Order)
    end
  end

  describe 'Callbacks' do
    it 'sets_price before save' do
      order_item = create(:order, :with_items, item_count: 3).order_items.last

      expect(order_item.price).to eq(order_item.item.price)
    end
  end
end
