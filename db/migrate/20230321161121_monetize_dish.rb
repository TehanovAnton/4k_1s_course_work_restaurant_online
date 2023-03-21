class MonetizeDish < ActiveRecord::Migration[6.1]
  def change
    add_monetize :dishes, :price
  end
end
