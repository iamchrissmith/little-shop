class State < ApplicationRecord
  has_many :cities

  validates :name, presence: true
  validates :abbr, presence: true
end
