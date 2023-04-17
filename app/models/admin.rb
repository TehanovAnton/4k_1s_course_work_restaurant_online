
class Admin < User
  has_one :restaurants_admin, foreign_key: 'user_id'
  has_one :restaurant, through: :restaurants_admin

  accepts_nested_attributes_for :restaurants_admin
end
