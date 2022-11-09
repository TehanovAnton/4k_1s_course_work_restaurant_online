class AddOnDeleteCascadeForOrdersDishesModel < ActiveRecord::Migration[6.1]
  def change
    remove_reference :orders_dishes, :order, foreign_key: true, index: true
    add_reference :orders_dishes, :order, foreign_key: true, on_delete: :cascade, index: true

    remove_reference :orders_dishes, :dish, foreign_key: true, index: true
    add_reference :orders_dishes, :dish, foreign_key: true, on_delete: :cascade, index: true
  end
end
