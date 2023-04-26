class CookUserBinding < ApplicationRecord
  belongs_to :cook, class_name: 'Cook', foreign_key: 'cook_id'
  belongs_to :user
end
