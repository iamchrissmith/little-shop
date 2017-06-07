class Category < ApplicationRecord
  has_many :item_categories
  has_many :items, through: :item_categories

  validates :name, presence: true, uniqueness: true
  validates_presence_of :slug

  before_validation :fill_slug

  def to_param
    slug
  end

  def self.find_by_slug(slug)
    Category.find_by(slug: slug)
  end

  private

  def fill_slug
    self.slug = name.downcase.gsub(' ', '_')
  end

end