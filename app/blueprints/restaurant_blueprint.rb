
class RestaurantBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :email, :address
  association :tables, blueprint: TableBlueprint
  association :company, blueprint: CompanyBlueprint
  
  field :company_id do |restaurant|
    restaurant.class.name
  end

  view :normal do
    association :restaurants_admins, blueprint: RestaurantsAdminsBlueprint
    association :menus, blueprint: MenuBlueprint, view: :with_dishes
  end

  view :search do
    field :type do |restaurant|
      restaurant.class.name
    end

    association :menus, blueprint: MenuBlueprint, view: :with_dishes
  end

  view :order do |restaurant|
    fields :name, :email, :address
  end
end
