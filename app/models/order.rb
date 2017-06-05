class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items
  has_many :items, through: :order_items
  accepts_nested_attributes_for :order_items

  belongs_to :address
  has_one :city, through: :address
  has_one :state, through: :city
  accepts_nested_attributes_for :address

  enum status: ['ordered', 'paid', 'completed', 'cancelled']

  def available_status; end

  def total_price
    order_items.sum(:price)
  end
end
