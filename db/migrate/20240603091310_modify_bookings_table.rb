class ModifyBookingsTable < ActiveRecord::Migration[7.1]
  def change
    change_column_null :bookings, :forwarder_id, true
  end
end
