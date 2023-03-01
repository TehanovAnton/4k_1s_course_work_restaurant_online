module DefaultControllerRequeredMethods
  module InstanceMethods
    def authorizable_instance(action)
      rais NotImplementedError, 'Model controller should provide authorizable_instance method'
    end
  end

  module ClassMethods
    def model_class
      raise NotImplementedError, 'Model controller should provide model class'
    end
  end
end

class DefaultController < ApplicationController
  before_action :authenticate_user!

  extend DefaultControllerRequeredMethods::ClassMethods
  include DefaultControllerRequeredMethods::InstanceMethods

  def create
    authorize authorizable_instance(:create)

    creater_service = creater_service_class.new(model_class, model_params)
    render(**creater_service.create)
  end

  def update
    authorize authorizable_instance(:update)

    updater_service = updater_service_class.new(model_class, model_params)
    render(**updater_service.update(@model))
  end

  def destroy
    authorize authorizable_instance(:destroy)

    destroy_service = destroy_service_class.new
    render(**destroy_service.destroy(@model))
  end

  private

  def set_model
    @model = model_class.find_by(id: params[:id])

    update_auth_header
    render json: { error: 'wrong menu params' } unless @model
  end

  def model_class
    self.class.model_class
  end

  def model_params
    params.require(model_scope).permit(model_class::PARAMS)
  end

  def model_scope
    model_class.name.downcase.to_sym
  end

  def updater_service_class
    model_class::MODEL_UPDATER_CLASS
  end

  def creater_service_class
    model_class::MODEL_CREATER_CLASS
  end

  def destroy_service_class
    model_class::MODEL_DESTROYER_CLASS
  end
end
