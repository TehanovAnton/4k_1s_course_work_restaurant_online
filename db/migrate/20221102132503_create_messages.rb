class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :text, null: false, default: ''

      t.timestamps
    end

    add_reference :messages, :restaurant, foreign_key: true, index: true
    add_reference :messages, :user, foreign_key: true, index: true
  end
end
