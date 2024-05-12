class CreateQuoteLineItems < ActiveRecord::Migration[7.1]
  def change
    create_table :quote_line_items do |t|
      t.string :description
      t.string :currency, limit: 3
      t.integer :cost, precision: 8, scale: 2
      t.string :frequency
      t.integer :quantity, precision: 8, scale: 2
      t.integer :total, precision: 10, scale: 2
      t.references :quotation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
