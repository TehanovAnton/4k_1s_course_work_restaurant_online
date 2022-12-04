class OrderOrderPlaceTypeColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :place_type, :integer, null: false
  end
end
