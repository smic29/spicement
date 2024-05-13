class AddApprovedToCompanies < ActiveRecord::Migration[7.1]
  def change
    add_column :companies, :approved, :boolean, default: false
  end
end
