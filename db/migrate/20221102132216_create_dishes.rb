class CreateDishes < ActiveRecord::Migration[6.1]
  def change
    create_table :dishes do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_reference :dishes, :menu, foreign_key: true, index: true
  end
end
