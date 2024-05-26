class Users::QuotationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quotation_service, only: [ :create ]

  def new
    @quotation = current_user.quotations.new
    @quotation.quote_line_items.build
    @quotation.build_client
  end

  def create
    @quotation = @service.create_quotation(quotation_params)

    if @quotation.save
      render :new
    else
      render :new
    end
  end

  private

  def quotation_params
    params.require(:quotation).permit(
      :status, :exchange_rate, :origin, :destination, :reference, :incoterm, client: [:name, :address],
      quote_line_items_attributes: [:description, :currency, :cost, :frequency, :quantity, :total]
    )
  end

  def set_quotation_service
    @service = Users::Quotation::Create.new(current_user)
  end
end
