class Users::QuotationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @quotation = current_user.quotations.new
    @quotation.quote_line_items.build
  end

  def create
    puts quotation_params
  end

  private

  def quotation_params
    params.require(:quotation).permit(
      :status, :exchange_rate, :origin, :destination, :incoterm, client: [:name, :address],
      quote_line_items_attributes: [:description, :currency, :cost, :frequency, :quantity, :total]
    )
  end
end
