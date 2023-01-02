super_admin = FactoryBot.create(:user, tr_type: 'SuperAdmin')
admin = FactoryBot.create(:user, tr_type: 'Admin')
customer = FactoryBot.create(:user, tr_type: 'Customer')

restaurant = FactoryBot.create(:restaurant)
restaurant.admins << admin

menu = FactoryBot.create(:menu, restaurant: restaurant)

['coffee', 'poriddge', 'toasts', 'milk', 'banana'].each do |meal|
  FactoryBot.create(:dish, name: meal, menu: menu)
end

(1..10).each do |number|
  FactoryBot.create(:table, number: number, restaurant: restaurant)
end

dishes = []
menu.dishes.each do |dish|
  dishes << { dish_id: dish.id }
end

order = FactoryBot.create(
  :order_with_dishes,
  user_id: customer.id,
  restaurant_id: restaurant.id,
  orders_dishes: dishes
)
