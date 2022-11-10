class Admin < User
  has_one :restaurants_admin, foreign_key: 'user_id'
  has_one :restaurant, through: :restaurants_admin
end