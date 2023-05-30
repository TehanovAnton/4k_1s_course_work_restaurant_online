# frozen_string_literal:true

module Validations
  module Orders
    module Validation
      extend ActiveSupport::Concern

      included do
        validates_with Orders::Validators::OrderUpdateOnlyEarlierHourBefore, on: :on_dishes_update        

        validates_presence_of :reservation, message: proc {
          "Could not create order without reservation."
        }

        validates_presence_of :restaurant, message: proc {
          "Could not create order without resturant."
        }

        validates_presence_of :user, message: proc {
          "Could not create order without user."
        }

        with_options if: :outside? do |order|
          order.validates_presence_of :orders_dishes, message: proc {
            "Could not create outside order without dishes."
          }
        end
      end
    end
  end
end
