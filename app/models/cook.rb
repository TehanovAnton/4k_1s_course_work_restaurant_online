# frozen_string_literal: true

class Cook < User
  MODEL_CREATER_CLASS = Models::Creaters::CookCreater
  MODEL_SERIALIZER_CLASS = UserBlueprint
  PARAMS = [
    :name, 
    :email, 
    :password, 
    :password_confirmation, 
    :type,
    cook_user_binding_attributes: [:user_id]
  ]

  has_one :restaurants_cook, foreign_key: :user_id, dependent: :destroy
  has_one :restaurant, through: :restaurants_cook

  has_one :cook_user_binding, dependent: :destroy
  has_one :user, through: :cook_user_binding

  validates_presence_of :cook_user_binding, message: proc {
    "Could not create cook without user binding"
  }

  validates_presence_of :restaurants_cook, message: proc {
    "Cook restaurant is not specified"
  }

  accepts_nested_attributes_for :restaurants_cook
  accepts_nested_attributes_for :cook_user_binding
end
