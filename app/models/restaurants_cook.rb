# frozen_string_literal: true

class RestaurantsCook < ApplicationRecord
  belongs_to :restaurant
  belongs_to :cook,
             class_name: 'Cook',
             foreign_key: 'user_id',
             optional: true,
             dependent: :destroy
end
