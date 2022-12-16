class MessagableTypeId < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :messageble_id, :integer, null: false
    add_column :messages, :messageble_type, :string, null: false
  end
end
