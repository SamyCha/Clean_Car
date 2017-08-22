User.destroy_all
Car.destroy_all
Category.destroy_all
Cleaning.destroy_all
puts "All tables are destroyed !"

puts "Generating some random users & cleaners"
# Users / Customers
User.create!(email: "test@test", password: "test", latitude: 44.8, longitude: -0.5)
User.create!(email: "test2@test", password: "test", address: "Sydney")
User.create!(email: "test3@test", password: "test", latitude: 31.13, longitude: 121)

# Cleaners
User.create!(email: "test4@test", password: "test", firstname: "Adrien", rating: 3, address: "Moscou", cleaner: true)
User.create!(email: "test5@test", password: "test", firstname: "Marco", rating: 4, address: "Tokyo", cleaner: true)
User.create!(email: "test6@test", password: "test", firstname: "Lolo", rating: 2, address: "Rio de Janeiro", cleaner: true)
User.create!(email: "test7@test", password: "test", firstname: "Marco", rating: 4, address: "Bordeaux", cleaner: true)
User.create!(email: "test8@test", password: "test", firstname: "Marco", rating: 5, address: "Bordeaux", cleaner: true)

puts "Seed done !"
