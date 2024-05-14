class AddStatusToBilling < ActiveRecord::Migration[7.1]
  def change
    add_column :billings, :status, :string, default: "Draft"
  end
end
