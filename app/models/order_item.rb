class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  before_create :set_price

  private

  def set_price
    self.price = item.price
  end
end
