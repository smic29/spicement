class AddCargoVolumeToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :cargo_volume, :float
  end
end
