class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  enum status: ['ordered', 'paid', 'completed', 'cancelled']

  def available_status
    
  end

end
