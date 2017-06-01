# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

Category.destroy_all
Item.destroy_all

puts "Creating categories and items"
3.times do
  Category.create!(name: Faker::Coffee.unique.variety)
end

10.times do
  Item.create!(
    name:         Faker::Coffee.unique.blend_name,
    description:  Faker::Coffee.notes,
    categories:   Category.all.shuffle.take(2),
    price:        rand(1.00..10.00).round(2),
    status:       0,
    # photo:        Faker::Fillmurray.image
  )
end
