puts "🌱 Seeding spices..."

# Seed your database here
require 'faker'
# Generate seed data for users
10.times do
  User.create(
    username: Faker::Internet.unique.username,
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end

# Generate seed data for pets
30.times do
  Pet.create(
    name: Faker::Creature::Animal.name,
    pet_id: Faker::Alphanumeric.unique.alphanumeric(number: 8),
    breed: Faker::Creature::Dog.breed,
    image_url: Faker::Avatar.image
  )
end

puts "✅ Done seeding!"
