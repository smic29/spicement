class Users::BillingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: [ :create, :update ]
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
    @billing = @service.create_billing(billing_params)

    if @billing.save
      puts "Creation Successful"
      render :show
    else
      puts "Creation Failed"
      puts @booking.errors.full_messages
      render :new
    end
  end

  def edit
    @booking = current_user.bookings.find(@billing.booking.id)
    @quotation = current_user.quotations.find(@billing.quotation.id)

  end

  def update
    processed_params = @service.update_billing(billing_params, @billing)

    if @billing.update(processed_params)
      render :show
    else
      puts @billing.errors.full_messages
      render :edit
    end
  end

  def pdf
    set_billing
    pdf_html = render_to_string(
      template: 'users/billings/pdf',
      layout: 'pdf',
      page_size: 'A4',
      margin: { top: 10, bottom: 10, left: 10, right: 10 },
      disable_smart_shrinking: true,
      print_media_type: true,
      no_pdf_compression: true
    )

    pdf = WickedPdf.new.pdf_from_string(pdf_html)
    send_data pdf, filename: 'file.pdf', type: 'application/pdf', disposition: 'inline'
  end

  private

  def set_billing
    @billing = current_user.billings.find(params[:id])
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
        :description, :currency, :cost, :quantity, :total, :id
      ]
    )
  end

  def set_service
    @service = Users::Billing::Create.new(current_user)
  end
end
