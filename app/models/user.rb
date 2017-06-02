class User < ApplicationRecord
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: true

  has_many :addresses
  has_many :cities, through: :addresses
  has_many :states, through: :cities
  accepts_nested_attributes_for :addresses

  enum role: ['guest', 'member', 'admin']
end
