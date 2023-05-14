module Models
  module Updaters
    class UserUpdater < Updater
      def update(model, serialize)
        return { json: model.errors.messages, status: :bad_request } unless model.update(**params)

        { json: serialize.call }
      end
    end
  end
end