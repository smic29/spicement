class ChangeCargoVolumeToStringInBookings < ActiveRecord::Migration[7.1]
  def up
    add_column :bookings, :cargo_volume_temp, :string

    Booking.reset_column_information
    Booking.find_each do |record|
      record.update_columns(cargo_volume_temp: record.cargo_volume.to_s)
    end

    remove_column :bookings, :cargo_volume
    rename_column :bookings, :cargo_volume_temp, :cargo_volume
  end

  def down
    add_column :bookings, :cargo_volume_temp, :float

    Booking.reset_column_information
    Booking.find_each do |record|
      record.update_columns(cargo_volume_temp: record.cargo_volume.to_f)
    end

    remove_column :bookings, :cargo_volume
    rename_column :bookings, :cargo_volume_temp, :cargo_volume
  end
end
