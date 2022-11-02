class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end

    add_reference :reservations, :table, foreign_key: true, index: true
    add_reference :reservations, :order, foreign_key: true, index: true
  end
end
