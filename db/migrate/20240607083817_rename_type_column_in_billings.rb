class RenameTypeColumnInBillings < ActiveRecord::Migration[7.1]
  def change
    rename_column :billings, :type, :doc_type
  end
end
