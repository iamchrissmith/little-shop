class Item < ApplicationRecord
  has_many :item_categories
  has_many :categories, through: :item_categories
  has_many :order_items
  has_many :orders, through: :order_items
  has_attached_file :photo, styles: {
    thumb: '300x300>',
    square:'450x450>',
  }

  validates_content_type :photo, :content_type => /\Aimage\/.*\Z/
  validates_presence_of :name, :description, :price, :categories
  validates_uniqueness_of :name
  validates_numericality_of :price

  enum status: ['active', 'retired']
end
