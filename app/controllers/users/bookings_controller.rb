class Users::BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = current_user.bookings.all
  end

  def show
    @booking = current_user.bookings.find(params[:id])
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
end
