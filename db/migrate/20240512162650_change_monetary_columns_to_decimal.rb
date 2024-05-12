class ChangeMonetaryColumnsToDecimal < ActiveRecord::Migration[7.1]
  def change
    change_column :billings, :total_amount, :decimal, precision: 10, scale: 2
    change_column :billings, :ex_rate, :decimal, precision: 10, scale: 2
    change_column :bookings, :cost, :decimal, precision: 10, scale: 2
    change_column :bookings, :receivable, :decimal, precision: 10, scale: 2
    change_column :bookings, :profit, :decimal, precision: 10, scale: 2
    change_column :quotations, :total_price, :decimal, precision: 10, scale: 2
    change_column :quote_line_items, :cost, :decimal, precision: 10, scale: 2
    change_column :quote_line_items, :total, :decimal, precision: 10, scale: 2
  end
end
