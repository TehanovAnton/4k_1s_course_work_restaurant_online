# frozen_string_literal:true

module Notifications
  class Base
    attr_reader :model, :mailer_action

    class << self
      def model_mailer
        self::MAILER
      end
    end

    def initialize(model, mailer_action)
      @model = model
      @mailer_action = mailer_action
    end

    def notify
      model_mailer.with(mailer_options)
                  .method(mailer_action)
                  .call
                  .deliver_now
    end

    private

    def model_mailer
      self.class.model_mailer
    end

    def mailer_options
      raise NotImplementedError, 'mailer options are not provided'
    end
  end
end
