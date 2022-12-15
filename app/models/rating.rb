class Rating < ApplicationRecord
  PARAMS = [
    :evaluation,
    :text
  ]

  belongs_to :order
end
