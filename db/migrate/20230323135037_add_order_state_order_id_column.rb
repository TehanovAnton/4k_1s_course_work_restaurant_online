class AddOrderStateOrderIdColumn < ActiveRecord::Migration[6.1]
  def change
    add_reference :order_states, :order
  end
end
