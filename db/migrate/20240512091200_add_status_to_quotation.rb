class AddStatusToQuotation < ActiveRecord::Migration[7.1]
  def change
    add_column :quotations, :status, :string, default: 'draft'
  end
end
