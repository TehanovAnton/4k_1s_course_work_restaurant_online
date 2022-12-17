class MessageBlueprint < Blueprinter::Base
  identifier :id

  fields :created_at, :text

  association :user, blueprint: UserBlueprint
end
