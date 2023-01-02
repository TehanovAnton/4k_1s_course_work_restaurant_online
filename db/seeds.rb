super_admin = FactoryBot.create(:user, tr_type: 'SuperAdmin')
admin = FactoryBot.create(:user, tr_type: 'Admin')
customer = FactoryBot.create(:user, tr_type: 'Customer')

restaurant = FactoryBot.create(:restaurant, :with_tables)
restaurant.admins << admin

menu = FactoryBot.create(:menu, :breakfast, restaurant: restaurant)
