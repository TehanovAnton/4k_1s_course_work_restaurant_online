class AddReservationReservationTypeColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :place_type
    add_column :reservations, :place_type, :integer, null: false
  end
end
