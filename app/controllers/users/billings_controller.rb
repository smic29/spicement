class Users::BillingsController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def show

  end

  def new
    @billing = current_user.billings.new

    @quotation = current_user.quotations.find(params[:quotation_id])
    @billing.quotation = @quotation

    @booking = current_user.bookings.find(params[:booking_id])
    @billing.booking = @booking

    @billing.billing_line_items.build
  end

  def create
    puts 'Entered Create Action'
  end

  def edit

  end

  def update

  end

  private

  def billing_params
    params.require(:billing).permit(
      :booking_id, :quotation_id, :type, :status, :ex_rate,
      quotation_attributes: [
        :origin, :destination, :id,
        client_attributes: [:name, :address, :tin_number, :id]
      ],
      booking_attributes: [
        :vessel_info, :bl_number, :eta, :cargo_volume, :services, :id
      ],
      billing_line_items_attributes: [
        :description, :currency, :cost, :quantity, :total
      ]
    )
  end
end
