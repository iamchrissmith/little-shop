class City < ApplicationRecord
  has_many :addresses
  belongs_to :state

  accepts_nested_attributes_for :state
end
