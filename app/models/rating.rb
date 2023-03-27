# frozen-string_literal:true

class Rating < ApplicationRecord
  PARAMS = %i[evaluation text order_id].freeze
  MODEL_CREATER_CLASS = Models::Creaters::Creater
  MODEL_SERIALIZER_CLASS = RatingBlueprint

  belongs_to :order
end
