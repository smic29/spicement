class AddConstraintsToCompanies < ActiveRecord::Migration[7.1]
  def change
    change_column_null :companies, :name, false
    add_index :companies, :company_code, unique: true
  end
end
