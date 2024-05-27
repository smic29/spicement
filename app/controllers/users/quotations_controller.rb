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
      puts @quotation.errors.full_messages
    end
  end

  def edit

  end

  def update
    update_params = @service.update_quotation(quotation_params)

    if @quotation.update(update_params)
      render :show
    else
      render :edit
      puts @quotation.errors.full_messages
    end
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
