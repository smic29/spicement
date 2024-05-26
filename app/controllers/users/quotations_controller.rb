class Users::QuotationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quotation_service, only: [ :create ]

  def new
    @quotation = current_user.quotations.new
    @quotation.quote_line_items.build
  end

  def create
    @service.create_quotation(quotation_params)
  end

  private

  def quotation_params
    params.require(:quotation).permit(
      :status, :exchange_rate, :origin, :destination, :incoterm, client: [:name, :address],
      quote_line_items_attributes: [:description, :currency, :cost, :frequency, :quantity, :total]
    )
  end

  def set_quotation_service
    @service = Users::Quotation::Create.new(current_user)
  end
end
