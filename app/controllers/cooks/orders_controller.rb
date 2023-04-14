# frozen_string_literal:true

module Cooks
  class OrdersController < ApplicationController
    before_action :authenticate_user!

    before_action :set_restaurant
    before_action :set_collection

    def index
      authorize [:cooks, @collection]

      render(json: model_serializer.render(@collection))
    end

    private

    class << self
      def model_class
        Order
      end
    end

    def model_serializer
      model_class::MODEL_SERIALIZER_CLASS
    end

    def model_class
      self.class.model_class
    end

    def set_collection
      now = Time.now
      @collection = policy_scope([:cooks, Order.where(restaurant: @restaurant)]).joins(:reservation)
                                                                                .where('reservations.start_at BETWEEN ? AND ?', now.beginning_of_day, now.end_of_day)
    end

    def set_restaurant
      @restaurant = Restaurant.find_by(id: params[:restaurant_id])

      update_auth_header
      render json: { error: 'wrong restaurant params' } unless @restaurant
    end
  end
end
