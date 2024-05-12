class AddContactInfoToClients < ActiveRecord::Migration[7.1]
  def change
    add_column :clients, :contact_name, :string
    add_column :clients, :phone_number, :string
    add_column :clients, :email, :string
    add_column :clients, :address, :string
  end
end
