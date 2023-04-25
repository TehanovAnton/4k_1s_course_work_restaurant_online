# frozen_string_literal:true

module Transitors
  class Transitor
    attr_reader :model, :model_class, :transition_name

    def initialize(model, transition_name)
      @model = model
      @model_class = @model.class
      @transition_name = transition_name.to_sym
    end

    def transit
      return { json: 'can not run transition', status: :unprocessable_entity } unless run_transit?

      run_transit
      { json: model_serializer.render(model) }
    end

    def notify_chanel
      order_json = OrderBlueprint.render(@model.order)
      ActionCable.server.broadcast('cooks_orders_channel', { order: order_json })
      ActionCable.server.broadcast('customers_orders_channel', { order: order_json })
    end

    private

    def run_transit?
      model.method("may_#{transition_name}?").call
    end

    def run_transit
      @model.method(trunsition_with_save).call
    end

    def trunsition_with_save
      "#{transition_name}!"
    end

    def model_serializer
      model_class::MODEL_SERIALIZER_CLASS
    end
  end
end
