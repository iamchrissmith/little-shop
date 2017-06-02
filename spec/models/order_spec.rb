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

    it 'should default to ordered' do
      expect(create(:order).ordered?).to be_truthy
    end

    it 'has a user' do
      order = create(:order)
      expect(order.user).to be_a(User)
    end

    describe 'has traits' do
      it 'has with items' do
        order = create(:order, :with_items, item_count: 3)

        expect(order.order_items.count).to eq(3)
        order.order_items.each do |order_item|
          expect(order_item).to be_a(OrderItem)
        end
      end
    end
  end

  describe 'Enums' do

    it 'defaults to ordered' do
      expect(create(:order).ordered?).to be_truthy
    end

    it 'can be paid' do
      expect(create(:order, status: 'paid').paid?).to be_truthy
    end

    it 'can be completed' do
      expect(create(:order, status: 'completed').completed?).to be_truthy
    end

    it 'can be cancelled' do
      expect(create(:order, status: 'cancelled').cancelled?).to be_truthy
    end
  end
end
