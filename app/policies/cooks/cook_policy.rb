# frozen_string_literal:true

module Cooks
  class CookPolicy < ApplicationPolicy
    private

    def cook?
      user.is_a? Cook
    end

    def record_restaurant
      raise NotImplementedError, 'Cook plicy should provide method for restaurant definition'
    end

    def refers_to_order_restaurant?
      # I use joind table model because Cook joins by has_one asscociation.
      RestaurantsCook.where(id: record_restaurant&.id)
                     .joins(:restaurant) # useless
                     .ids
                     .include?(user.restaurants_cook.id)
    end
  end
end
