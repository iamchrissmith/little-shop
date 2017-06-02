class User < ApplicationRecord
  has_secure_password

  has_many :addresses
  has_many :cities, through: :addresses
  has_many :states, through: :cities
  accepts_nested_attributes_for :addresses, :cities, :states
end
