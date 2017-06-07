class Item < ApplicationRecord
  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories
  has_many :order_items
  has_many :orders, through: :order_items
  has_attached_file :photo,
                    default_url: ':style/coffee-beans-shot.png',
                    :storage => :cloudinary,
                    :path => ':style/:filename',
                    styles: {
                              thumb: '300x300>',
                              large: '450x450>'
                            }
  # do_not_validate_attachment_file_type :photo
  validates_attachment :photo, content_type: {content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates_presence_of :name, :description, :price, :categories
  validates_uniqueness_of :name
  validates_numericality_of :price, greater_than: 0

  enum status: ['active', 'retired']
end
