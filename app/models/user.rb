class User < ApplicationRecord
  has_many :orders
  has_many :messages
end
