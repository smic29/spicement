class AddTinNumberToClients < ActiveRecord::Migration[7.1]
  def change
    add_column :clients, :tin_number, :string
  end
end
