class Users::BillingsController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def show

  end

  def new
    @billing = current_user.bookings.new

    @quotation = current_user.quotations.find(params[:quotation_id])
    @billing.quotation = @quotation

    @booking = current_user.bookings.find(params[:booking_id])
  end

  def create
    puts 'Triggered'
  end

  def edit

  end

  def update

  end
end