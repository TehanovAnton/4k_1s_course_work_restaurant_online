# frozen_string_literal:true

class OrderState < ApplicationRecord
  belongs_to :order

  include AASM

  aasm do
  end
end
