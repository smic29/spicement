class Users::QuotationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quotation, only: [ :show, :edit, :update ]
  before_action :set_quotation_service, only: [ :create, :update ]

  def index
    @quotations = current_user.quotations.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @quotation = current_user.quotations.new
    @quotation.quote_line_items.build
    @quotation.build_client
  end

  def create
    @quotation = @service.create_quotation(quotation_params)

    if @quotation.save
      render :show
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @service.update_quotation(quotation_params, @quotation)
      render :show
    else
      render :edit
    end
  end

  def pdf
    set_quotation
    pdf_html = render_to_string(
      template: 'users/quotations/pdf',
      layout: 'pdf',
      page_size: 'A4',
      margin: { top: 10, bottom: 10, left: 10, right: 10 },
      disable_smart_shrinking: true,
      print_media_type: true,
      no_pdf_compression: true
    )
    pdf = WickedPdf.new.pdf_from_string(pdf_html)
    send_data pdf, filename: "file.pdf", type: 'application/pdf', disposition: 'inline'
  end

  private

  def set_quotation
    @quotation = current_user.quotations.find(params[:id])
  end

  def quotation_params
    params.require(:quotation).permit(
      :status, :exchange_rate, :origin, :destination, :incoterm, client_attributes: [:name, :address, :id],
      quote_line_items_attributes: [:description, :currency, :cost, :frequency, :quantity, :total, :id]
    )
  end

  def set_quotation_service
    @service = Users::Quotation::Create.new(current_user)
  end
end
