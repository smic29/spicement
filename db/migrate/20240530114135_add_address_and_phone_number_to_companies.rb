class AddAddressAndPhoneNumberToCompanies < ActiveRecord::Migration[7.1]
  def change
    add_column :companies, :address, :string
    add_column :companies, :contact_number, :string
  end
end
