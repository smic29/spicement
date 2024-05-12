class ChangeIntegerIntoFloatForColumns < ActiveRecord::Migration[7.1]
  def change
    change_column :quote_line_items, :cost, :float, precision: 8, scale: 2
    change_column :quote_line_items, :quantity, :float, precision: 8, scale: 2
    change_column :quote_line_items, :total, :float, precision: 8, scale: 2

    change_column :bookings, :cost, :float, precision: 10, scale: 2
    change_column :bookings, :receivable, :float, precision: 10, scale: 2
    change_column :bookings, :profit, :float, precision: 10, scale: 2
  end
end
