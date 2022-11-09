class AddOnDeleteCascadeForOrdersTableModel < ActiveRecord::Migration[6.1]
  def change
    remove_reference :tables, :restaurant, foreign_key: true, index: true
    add_reference :tables, :restaurant, foreign_key: true, on_delete: :cascade, index: true
  end
end
