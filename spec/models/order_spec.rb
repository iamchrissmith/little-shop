require 'rails_helper'

RSpec.describe Order, type: :model do

  describe 'Validations' do
    it { should belong_to(:user) }
    it { should have_many(:items).through(:order_items) }
  end

  describe 'Factories' do

    it 'is an Order' do
      expect(create(:order)).to be_a(Order)
    end

    it 'has a user' do
      order = create(:order)
      expect(order.user).to be_a(User)
    end

    it 'has many order_items' do
      order = create(:order, item_count: 3)

      expect(order.order_items.count).to eq(3)
      order.order_items.each do |order_item|
        expect(order_item).to be_a(OrderItem)
      end
    end

    it 'has many items' do
      order = create(:order, item_count: 3)

      expect(order.items.count).to eq(3)
      order.items.each do |item|
        expect(item).to be_a(Item)
      end
    end
  end
end
