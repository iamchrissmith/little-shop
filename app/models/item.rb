class Item < ApplicationRecord
  has_many :item_categories
  has_many :categories, through: :item_categories
  has_many :order_items
  has_many :orders, through: :order_items
  has_attached_file :photo, styles: {
    thumb: '300x300>',
    large: '450x450>',
  }
  do_not_validate_attachment_file_type :photo
  # validates_attachment_presence :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_presence_of :name, :description, :price, :categories
  validates_uniqueness_of :name
  validates_numericality_of :price, greater_than: 0

  enum status: ['active', 'retired']
end
