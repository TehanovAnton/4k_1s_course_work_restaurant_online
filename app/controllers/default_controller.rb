class DefaultController < ApplicationController
  MODEL = ''.freeze

  before_action :authenticate_user!

  def create
    authorize authorizable_instance(:create)

    creater_service = creater_service_class.new(model_params)
    render(**creater_service.create)
  end

  def update
    authorize authorizable_instance(:update)

    updater_service = updater_service_class.new(model_params)
    render(**updater_service.update(@model))
  end

  def destroy
    binding.pry
    authorize authorizable_instance(:destroy)

    destroy_service = destroy_service_class.new
    render(**destroy_service.destroy(@model))
  end

  private

  class << self
    def model
      self::MODEL
    end
  end

  def model_params
    params.require(model_scope).permit(model::PARAMS)
  end

  def model_scope
    model.name.downcase.to_sym
  end

  def model
    self.class.model
  end

  def updater_service_class
    Models::Updaters::Updater
  end

  def creater_service_class
    Models::Creaters::Creater
  end

  def destroy_service_class
    Models::Destroyers::Destroyer
  end

  def authorizable_instance(action)
    rais NotImplementedError, 'Action should have authorizable_instance method'
  end
end
