class State < ApplicationRecord
  has_many :cities

  validates_presence_of :name, :abbr
  validates_uniqueness_of :name, :abbr
end
