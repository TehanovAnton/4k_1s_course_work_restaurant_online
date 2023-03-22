# frozen_literal_string:true

FactoryBot.define do
  factory :order do
    user_id {}
    restaurant_id {}

    factory :order_with_dishes do
      transient do
        orders_dishes {}
      end

      after(:create) do |order, evaluator|
        evaluator.orders_dishes.each do |order_dish|
          order_dish[:order_id] = order.id
          order.orders_dishes << OrdersDish.new(**order_dish)
        end

        order.reload

        binding.pry
      end
    end
  end
end
