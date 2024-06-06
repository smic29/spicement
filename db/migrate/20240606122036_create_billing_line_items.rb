class CreateBillingLineItems < ActiveRecord::Migration[7.1]
  def change
    create_table :billing_line_items do |t|
      t.string "description"
      t.string "currency", limit: 3
      t.decimal "cost", precision: 10, scale: 2
      t.float "quantity"
      t.decimal "total", precision: 10, scale: 2
      t.references :billing, null: false, foreign_key: true

      t.timestamps
    end
  end
end
