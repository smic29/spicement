class AddUserReferenceToForwarders < ActiveRecord::Migration[7.1]
  def change
    add_reference :forwarders, :users, null: false, foreign_key: true
  end
end
