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

  def available_status
    if status == 'ordered'
      {'ordered' => 0, 'paid' => 1, 'cancelled' => 3}
    elsif status == 'paid'
      {'paid' => 1, 'completed' => 2, 'cancelled' => 3}
    elsif status == 'completed'
      {'completed' => 2}
    elsif status == 'cancelled'
      {'cancelled' => 3}
    end
  end

  # def self.order_status
  #   {
  #   all: Order.order('created_at DESC'),
  #   ordered: Order.where(status: "ordered").order('created_at DESC'),
  #   paid: Order.where(status: "paid").order('created_at DESC'),
  #   completed: Order.where(status: "completed").order('created_at DESC'),
  #   cancelled: Order.where(status: "cancelled").order('created_at DESC')
  #   }
  # end

  def total_price
    order_items.sum(:price)
  end

  def address_attributes=(address_attributes)
    address = Address.create(address_attributes)
    self.address = address
  end
end
