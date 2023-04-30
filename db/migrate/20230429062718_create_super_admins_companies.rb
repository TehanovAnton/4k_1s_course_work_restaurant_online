class CreateSuperAdminsCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :super_admins_companies do |t|
      t.references :company, foreign_key: true, index: true, on_delete: :cascade
      t.references :user, foreign_key: true, index: true, on_delete: :cascade

      t.timestamps
    end
  end
end
