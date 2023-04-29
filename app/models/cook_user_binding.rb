class CookUserBinding < ApplicationRecord
  belongs_to :cook, class_name: 'Cook', foreign_key: 'cook_id', optional: true
  belongs_to :user, class_name: 'User', foreign_key: 'user_id', optional: true
end
