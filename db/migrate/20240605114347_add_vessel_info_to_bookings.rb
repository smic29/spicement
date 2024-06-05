class AddVesselInfoToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :vessel_info, :string
  end
end
