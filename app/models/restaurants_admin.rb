class RestaurantsAdmin < ApplicationRecord
  belongs_to :restaurant
  belongs_to :admin, class_name: 'User', foreign_key: 'user_id'
end
