class Users::BillingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: [ :create ]
  before_action :set_billing, only: [ :show, :edit, :update ]

  def index
    @billings = current_user.billings.includes(:booking).all.order('bookings.id', :created_at)
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
    @booking = @service.create_billing(billing_params)

    if @booking.save
      puts "Creation Successful"
    else
      puts "Creation Failed"
      puts @booking.errors.full_messages
    end
  end

  def edit

  end

  def update

  end

  private

  def set_billing
    @billing = current_user.find(params[:id])
  end

  def billing_params
    params.require(:billing).permit(
      :booking_id, :quotation_id, :doc_type, :status, :ex_rate,
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

  def set_service
    @service = Users::Billing::Create.new(current_user)
  end
end
