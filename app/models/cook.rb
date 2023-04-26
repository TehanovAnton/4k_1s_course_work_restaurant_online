# frozen_string_literal: true

class Cook < User
  has_one :restaurants_cook, foreign_key: :user_id, dependent: :destroy
  has_one :restaurant, through: :restaurants_cook

  has_one :cook_user_binding, dependent: :destroy
  has_one :user, through: :cook_user_binding

  accepts_nested_attributes_for :restaurants_cook
end
