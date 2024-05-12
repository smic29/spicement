class CreateQuotations < ActiveRecord::Migration[7.1]
  def change
    create_table :quotations do |t|
      t.string :incoterm
      t.float :exchange_rate, precision: 8, scale: 2
      t.string :origin
      t.string :destination
      t.float :total_price, precision: 10, scale: 2
      t.references :user, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
