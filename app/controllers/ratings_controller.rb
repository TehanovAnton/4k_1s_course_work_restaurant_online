# frozen_string_literal:true

class RatingsController < DefaultController
  before_action :authenticate_user!

  before_action :set_model, only: %i[update
                                     destroy
                                     show]

  def destroy
    authorize authorizable_instance(:destroy)

    destroy_service = destroy_service_class.new(@model)
    render(**destroy_service.destroy)
  end

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
