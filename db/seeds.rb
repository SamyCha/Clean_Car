User.destroy_all
Car.destroy_all
Category.destroy_all
Cleaning.destroy_all
puts "All tables are destroyed !"

puts "Generating random users, cleaners, categories, cars & cleanings ! =)"
# Users / Customers
User.create!(email: "test@test", password: "test", latitude: 44.8, longitude: -0.5, phonenumber: "1234")
User.create!(email: "test3@test", password: "test", latitude: 31.13, longitude: 121, phonenumber: Faker::PhoneNumber.cell_phone)
User.create!(email: "test2@test", password: "test", address: "Ottawa, Canada", phonenumber: Faker::PhoneNumber.cell_phone, latitude: nil, longitude: nil)

# Cleaners in France
x = User.new(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, email: "test4@test", password: "test", address: "Marseille, France", phonenumber: Faker::PhoneNumber.cell_phone, cleaner: true)
x.save!

User.create!(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, email: "test5@test", password: "test", address: "Lyon, France", phonenumber: Faker::PhoneNumber.cell_phone, cleaner: true)
User.create!(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, email: "test6@test", password: "test", address: "Bretagne, France", phonenumber: Faker::PhoneNumber.cell_phone, cleaner: true)
User.create!(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, email: "test7@test", password: "test", address: "Strasbourg, France", phonenumber: Faker::PhoneNumber.cell_phone, cleaner: true)
User.create!(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, email: "test8@test", password: "test", address: "Corse, France", phonenumber: Faker::PhoneNumber.cell_phone, cleaner: true)

# Cleaners in other parts of the world
User.create!(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, email: "test9@test", password: "test", address: "Bresil", phonenumber: Faker::PhoneNumber.cell_phone, cleaner: true)

User.create!(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, email: "test10@test", password: "test", address: "Korea", phonenumber: Faker::PhoneNumber.cell_phone, cleaner: true)

User.create!(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, email: "test11@test", password: "test", address: "Sydney", phonenumber: Faker::PhoneNumber.cell_phone, cleaner: true)
User.create!(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, email: "test12@test", password: "test", address: "Shanghai", phonenumber: Faker::PhoneNumber.cell_phone, cleaner: true)

# Cleaners near Bordeaux
User.create!(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, email: "test13@test", password: "test", address: "Gambetta Bordeaux", phonenumber: Faker::PhoneNumber.cell_phone, cleaner: true)
User.create!(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, email: "test14@test", password: "test", address: "Chartrons Bordeaux", phonenumber: Faker::PhoneNumber.cell_phone, cleaner: true)
User.create!(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, email: "test15@test", password: "test", address: "Victoire Bordeaux", phonenumber: Faker::PhoneNumber.cell_phone, cleaner: true)

# Categories
y = Category.new(name: "small", price: 10)
y.save!

Category.create!(name: "medium", price: 13)
Category.create!(name: "large", price: 18)

# Cars
z = Car.new(immatriculation: "DG-672-RK", brand: "PEUGEOT", model: "206", color: "noir", user_id: x.id, category_id: y.id)
z.save!
# Car.create!(immatriculation: "BC-921-DD", brand: "RENAULT", model: "Clio", color: "noir", user: x)
# Car.create!(immatriculation: "CW-434-HP", brand: "NISSAN", model: "Qashqai", color: "noir", user: x)

# Cleanings
# as stated on Trello, cleaning_status available are "pending", "confirmed" or "canceled"
cleaning = Cleaning.new(place: Faker::Address.city, period: Faker::Date.between( Date.today, 1.year.from_now), comment_access: "usefull comment on where is the car", requirements: true, rating: 4, cleaning_status: "confirmed", images: "whatever attachinary", user: x, car: z)
cleaning.save!


puts "Seed done !"
