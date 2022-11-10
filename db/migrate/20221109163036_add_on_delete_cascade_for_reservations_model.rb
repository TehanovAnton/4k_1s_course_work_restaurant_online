class AddOnDeleteCascadeForReservationsModel < ActiveRecord::Migration[6.1]
  def change
    remove_reference :reservations, :table, foreign_key: true, index: true
    add_reference :reservations, :table, foreign_key: true, on_delete: :cascade, index: true
    
    remove_reference :reservations, :order, foreign_key: true, index: true
    add_reference :reservations, :order, foreign_key: true, on_delete: :cascade, index: true
  end
end
