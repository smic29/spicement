class AddUniqueEmailToUsers < ActiveRecord::Migration[7.1]
  def change
    add_index :users, [:email, :company_id], unique: true
  end
end
