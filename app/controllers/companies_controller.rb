class CompaniesController < Default::Controller
  before_action :set_model, only: %i[update]
  private

  class << self
    def model_class
      Company
    end
  end

  def authorizable_instance(action)
    case action
    when :create
      Company
    when :update
      @model
    end
  end
end