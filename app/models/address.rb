class Address < ApplicationRecord
  belongs_to :city
  belongs_to :user

  has_one :state, through: :city

  accepts_nested_attributes_for :city
end
