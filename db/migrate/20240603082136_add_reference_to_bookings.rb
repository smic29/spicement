class AddReferenceToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :b_reference, :string
  end
end
