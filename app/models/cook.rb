# frozen_string_literal: true

class Cook < User
  has_one :restaurants_cook, foreign_key: :user_id, dependent: :destroy
  has_one :restaurant, through: :restaurants_cook
end
