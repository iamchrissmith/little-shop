class Address < ApplicationRecord
  belongs_to :city
  has_many :orders

  has_one :state, through: :city

  accepts_nested_attributes_for :city

  validates :city_id, presence: true
  validates :address, presence: true
  validates :zipcode, presence: true
end
