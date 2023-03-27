# frozen_string_literal:true

class RatingsController < DefaultController
  before_action :authenticate_user!

  before_action :set_model, only: %i[update
                                     destroy
                                     show]

  private

  class << self
    def model_class
      Rating
    end
  end

  def authorizable_instance(action)
    case action
    when :create
      Rating
    end
  end
end
