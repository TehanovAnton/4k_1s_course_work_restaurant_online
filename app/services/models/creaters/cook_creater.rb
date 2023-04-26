module Models
  module Creaters
    class CookCreater < Creater
      MAILER = CookMailer
      def initialize(params)
        super(Cook, params)
      end

      def create
        super

        binding.pry

        if @model.id
          MAILER.with(user: @model)
                .account_created
                .deliver_now
        end
      end
    end
  end
end

   