class CreateCookUserBindings < ActiveRecord::Migration[6.1]
  def change
    create_table :cook_user_bindings do |t|
      t.bigint :cook_id, null: false
      t.foreign_key :users, column: 'cook_id'

      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
