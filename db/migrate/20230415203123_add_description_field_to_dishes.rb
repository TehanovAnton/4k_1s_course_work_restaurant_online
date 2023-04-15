class AddDescriptionFieldToDishes < ActiveRecord::Migration[6.1]
  def change
    add_column :dishes, :description, :string
  end
end
