
class Admin < User
  has_many :restaurants_admins, foreign_key: 'user_id'
  has_many :restaurants, through: :restaurants_admins

  accepts_nested_attributes_for :restaurants_admins
end
