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

  end

  private

  def set_booking
    @booking = current_user.bookings.find(params[:id])
  end
end
