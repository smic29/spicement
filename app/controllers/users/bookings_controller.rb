class Users::BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [ :show, :edit, :update ]

  def index
    @bookings = current_user.bookings.all
  end

  def show

  end

  def create
    quotation = current_user.quotations.find(params[:quotation_id])
    cost = 0
    profit = quotation.total_price - cost
    @booking = quotation.build_booking(user_id: quotation.user_id, receivable: quotation.total_price, cost: 0, profit: profit)

    if @booking.save
      render :show
    else
      puts @booking.errors.full_messages
      render :index
    end
  end

  def edit

  end

  def update
    if @booking.update(booking_params)
      render :show
    else
      render :edit
    end
  end

  private

  def set_booking
    @booking = current_user.bookings.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(
      :quotation_id, :status, :bl_number, :vessel_info, :cargo_volume, :eta,
      quotation_attributes: [
        :origin, :destination, :incoterm, :id,
        client_attributes: [ :name, :address, :tin_number, :id ]
      ]
    )
  end
end
