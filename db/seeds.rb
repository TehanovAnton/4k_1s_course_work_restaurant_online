# Users
super_admin = FactoryBot.create(:user, tr_type: 'SuperAdmin', name: 'anton')
admin = FactoryBot.create(:user, tr_type: 'Admin')
customer = FactoryBot.create(:user, tr_type: 'Customer')
cook = FactoryBot.create(:cook)

# Companies
company = FactoryBot.create(:company)

# Restaurants
restaurant = FactoryBot.create(:restaurant, :with_tables)
restaurant.admins << [admin, super_admin]

# Menus
menu = FactoryBot.build(:menu_with_dishes, restaurant_id: restaurant.id)
menu.save
