class Address < ApplicationRecord
  belongs_to :city
  belongs_to :user

  has_one :state, through: :city

  accepts_nested_attributes_for :city

  validates :city_id, presence: true
  validates :user_id, presence: true
  validates :address, presence: true
  validates :zipcode, presence: true
end
