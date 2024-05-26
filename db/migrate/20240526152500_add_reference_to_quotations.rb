class AddReferenceToQuotations < ActiveRecord::Migration[7.1]
  def change
    add_column :quotations, :reference, :string
    add_index :quotations, :reference, unique: true
  end
end
