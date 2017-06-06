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
      {'ordered' => 'Ordered', 'paid' => 'Paid', 'cancelled' => 'Cancelled'}
    elsif status == 'paid'
      {'paid' => 'Paid', 'completed' => 'Completed', 'cancelled' => 'Cancelled'}
    elsif status == 'completed'
      {'completed' => 'Completed'}
    elsif status == 'cancelled'
      {'cancelled' => 'Cancelled'}
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
