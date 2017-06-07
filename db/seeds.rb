require 'faker'

Item.destroy_all
Category.destroy_all
User.destroy_all
State.destroy_all
City.destroy_all
Address.destroy_all

puts "Creating categories"

10.times do
  Category.create(name: Faker::Coffee.unique.variety)
end

puts "#{Category.all.count} Categories created"
puts "Creating Items"

images = (1..27).collect { |n| "#{n}.png" }

27.times do |i|
  item = Item.create!(
    name:         Faker::Coffee.unique.blend_name,
    description:  "#{Faker::Coffee.notes}. #{Faker::TwinPeaks.quote}",
    categories:   Category.all.shuffle.take(rand(1..3)),
    price:        rand(10.00..1000.00).round(2),
    status:       0,
    photo:        File.open("app/assets/images/coffee/#{images[i]}")
  )
  puts "Item #{item.name} created."
end

puts "Created #{Item.all.count} items"
puts "Creating Users"

User.create(email: 'admin@admin.com', first_name: 'Madman', last_name: 'Max', password: 'password', role: 'admin')
User.create(email: 'user@user.com', first_name: 'Sorrow', last_name: 'Sal', password: 'password')

puts "Creating States"

50.times { State.create(name: Faker::Address.state, abbr: Faker::Address.state_abbr)}
