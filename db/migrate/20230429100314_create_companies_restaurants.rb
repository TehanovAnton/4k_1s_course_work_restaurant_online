class CreateCompaniesRestaurants < ActiveRecord::Migration[6.1]
  def change
    create_table :companies_restaurants do |t|
      t.references :restaurant, null: false, foreign_key: true, on_delete: :cascade
      t.references :company, null: false, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
