# Users
super_admin = FactoryBot.create(:user, tr_type: 'SuperAdmin', name: 'Anton-Admin')
admin = FactoryBot.create(:user, tr_type: 'Admin')
customer = FactoryBot.create(:user, tr_type: 'Customer', name: 'Anton-Customer', email: 'tehanovanton@gmail.com')

# Companies
company = FactoryBot.create(:company)

# Restaurants
restaurant = FactoryBot.create(:restaurant, :with_tables)
restaurant.admins << [admin, super_admin]

cook = FactoryBot.create(:cook, name: 'Anton-Cook')

# Menus
menu = FactoryBot.build(:menu_with_dishes, restaurant_id: restaurant.id)
menu.save
