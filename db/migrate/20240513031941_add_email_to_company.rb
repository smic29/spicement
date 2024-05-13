class AddEmailToCompany < ActiveRecord::Migration[7.1]
  def change
    add_column :companies, :email, :string, null: false
    add_index :companies, :email, unique: true
  end
end
