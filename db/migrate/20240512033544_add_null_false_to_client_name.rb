class AddNullFalseToClientName < ActiveRecord::Migration[7.1]
  def change
    change_column :clients, :name, :string, null: false
  end
end
