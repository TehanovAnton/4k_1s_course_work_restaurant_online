# frozen_string_literal:true

class RatingsController < ModelResponse::Controller
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
    when :update, :destroy
      @model
    end
  end
end
