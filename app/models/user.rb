class User < ApplicationRecord
  has_secure_password

  has_many :addresses
  has_many :cities, through: :addresses
  has_many :states, through: :cities

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email, :case_sensitive => false

  accepts_nested_attributes_for :addresses

  enum role: ['user', 'admin']
end
