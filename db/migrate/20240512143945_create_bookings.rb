class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :quotation, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :forwarder, null: false, foreign_key: true
      t.string :services
      t.string :bl_number
      t.integer :cost, precision: 10, scale: 2
      t.integer :receivable, precision: 10, scale: 2
      t.integer :profit, precision: 10, scale: 2
      t.string :status, default: "Ongoing"
      t.date :eta

      t.timestamps
    end
  end
end
