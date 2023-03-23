class AasmCreateOrderStates < ActiveRecord::Migration[6.1]
  def change
    create_table(:order_states) do |t|
      t.string :aasm_state
      t.timestamps null: false
    end
  end
end
