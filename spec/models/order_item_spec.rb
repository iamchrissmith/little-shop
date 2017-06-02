require 'rails_helper'

RSpec.describe OrderItem, type: :model do

  describe 'Validations' do

    it { should belong_to(:item) }
    it { should belong_to(:order) }

  end

  describe 'Factories' do

    it 'is a OrderItem' do
      expect(create(:order_item)).to be_a(OrderItem)
    end

    it 'has an item and a user' do
      order_item = create(:order_item)

      expect(order_item.item).to be_a(Item)
      expect(order_item.order).to be_a(Order)
    end

  end

  describe 'Methods' do

    it 'sets price' do
      order = create(:order)
      order_item = order.order_items.last

      expect(order_item.price).to eq(order_item.item.price)
    end

  end
end