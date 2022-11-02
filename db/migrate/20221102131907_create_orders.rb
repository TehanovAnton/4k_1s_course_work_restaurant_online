class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.timestamps
    end

    add_reference :orders, :restaurant, foreign_key: true, index: true
    add_reference :orders, :user, foreign_key: true, index: true
  end
end
