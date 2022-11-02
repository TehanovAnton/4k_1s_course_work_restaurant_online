class CreateOrdersDishesTable < ActiveRecord::Migration[6.1]
  def change
    create_table :orders_dishes do |t|

      t.timestamps
    end

    add_reference :orders_dishes, :order, foreign_key: true, index: true
    add_reference :orders_dishes, :dish, foreign_key: true, index: true
  end
end
