class CreatePeople < ActiveRecord::Migration[7.1]
  def change
    create_table :people do |t|
      t.string :name
      t.string :phone_number
      t.string :email
      t.references :client, foreign_key: true
      t.references :forwarder, foreign_key: true

      t.timestamps
    end
  end
end
