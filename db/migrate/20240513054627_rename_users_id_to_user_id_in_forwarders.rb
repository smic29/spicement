class RenameUsersIdToUserIdInForwarders < ActiveRecord::Migration[7.1]
  def change
    rename_column :forwarders, :users_id, :user_id
  end
end
