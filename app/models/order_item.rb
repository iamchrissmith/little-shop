class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  after_create :set_price

  private

  def set_price
    self.price = item.price
  end

end
