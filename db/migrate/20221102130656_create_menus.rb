class CreateMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :menus do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_reference :menus, :restaurant, foreign_key: true, index: true
  end
end
