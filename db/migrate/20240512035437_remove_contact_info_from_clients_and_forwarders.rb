class RemoveContactInfoFromClientsAndForwarders < ActiveRecord::Migration[7.1]
  def change
    remove_column :clients, :contact_name, :string
    remove_column :clients, :phone_number, :string
    remove_column :clients, :email, :string

    remove_column :forwarders, :contact_name, :string
    remove_column :forwarders, :phone_number, :string
    remove_column :forwarders, :email, :string
  end
end
