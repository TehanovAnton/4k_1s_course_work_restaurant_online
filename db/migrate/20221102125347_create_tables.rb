class CreateTables < ActiveRecord::Migration[6.1]
  def change
    create_table :tables do |t|
      t.integer :number, null: false

      t.timestamps
    end

    add_reference :tables, :restaurant, foreign_key: true, index: true
  end
end
