class Users::BillingsController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def show

  end

  def new
    @billing = current_user.bookings.new
    @quote_id = params[:quotation_id]
    @booking_id = params[:booking_id]
  end

  def create

  end

  def edit

  end

  def update

  end
end
