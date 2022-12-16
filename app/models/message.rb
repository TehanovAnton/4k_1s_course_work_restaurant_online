class Message < ApplicationRecord
  belongs_to :restaurant

  belongs_to :messageble, polymorphic: true
  belongs_to :user
end
