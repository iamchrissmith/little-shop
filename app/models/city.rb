class City < ApplicationRecord
  has_many :addresses
  belongs_to :state

  accepts_nested_attributes_for :state

  validates :name, presence: true, uniqueness: true
  validates :state_id, presence: true
end
