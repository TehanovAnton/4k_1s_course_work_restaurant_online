# Users
super_admin = FactoryBot.create(:user, tr_type: 'SuperAdmin')
admin = FactoryBot.create(:user, tr_type: 'Admin')
customer = FactoryBot.create(:user, tr_type: 'Customer')
cook = FactoryBot.create(:user, tr_type: 'Cook')

# Companies
company = FactoryBot.create(:company)

# Restaurants
restaurant = FactoryBot.create(:restaurant, :with_tables)
restaurant.admins << [admin, super_admin]

menu = FactoryBot.create(:menu, :breakfast, restaurant: restaurant)
