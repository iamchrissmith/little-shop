class Item < ApplicationRecord
  has_many :item_categories
  has_many :categories, through: :item_categories
  has_many :order_items
  has_many :orders, through: :order_items

  validates_presence_of :name, :description, :price, :categories
  validates_uniqueness_of :name
  validates_numericality_of :price

  enum status: ['active', 'retired']
end