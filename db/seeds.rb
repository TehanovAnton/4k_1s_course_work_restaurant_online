super_admin = SuperAdmin.create(name: "Super Admin", email: "super_admin@gmail.com", password: "123123", password_confirmation: "123123")

restaurant = Restaurant.create(name: "Depo", email: "depo@gmail.com", address: "Okt 16")

menu = Menu.create(name: "Menu #1", restaurant: restaurant)

10.times do |i|
  Dish.create(name: "Dish ##{i}", menu: menu)
end

10.times do |i|
  Table.create(number: i, restaurant: restaurant)
end
