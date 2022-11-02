class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.integer :evaluation, null: false
      t.string :text

      t.timestamps
    end

    add_reference :ratings, :order, foreign_key: true, index: true
  end
end
