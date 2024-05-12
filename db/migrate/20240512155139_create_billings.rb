class CreateBillings < ActiveRecord::Migration[7.1]
  def change
    create_table :billings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :booking, null: false, foreign_key: true
      t.references :quotation, null: false, foreign_key: true
      t.float :total_amount, precision: 10, scale: 2
      t.string :type
      t.float :ex_rate, precision: 8, scale: 2
      t.string :job_description

      t.timestamps
    end
  end
end
