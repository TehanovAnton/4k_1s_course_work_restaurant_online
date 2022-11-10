class CreateRestaurantsAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurants_admins do |t|
      t.references :restaurant, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true
      
      t.timestamps
    end    
  end
end
