class Message < ApplicationRecord
  PARAMS = [
    :user_id,
    :restaurant_id,
    :text
  ]

  belongs_to :restaurant

  belongs_to :messageble, polymorphic: true
  belongs_to :user
end
