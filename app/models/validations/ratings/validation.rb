# frozen_string_literal:true

module Validations
  module Ratings
    module Validation
      extend ActiveSupport::Concern

      included do
        validates_with Ratings::Validators::ReferredToFinishedOrderValidator
      end
    end
  end
end
