class CreateForwarders < ActiveRecord::Migration[7.1]
  def change
    create_table :forwarders do |t|
      t.string :name, null: false
      t.string :contact_name
      t.string :phone_number
      t.string :email
      t.string :address

      t.timestamps
    end
  end
end
