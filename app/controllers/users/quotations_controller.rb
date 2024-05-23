class Users::QuotationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @quotation = current_user.quotations.new
  end

  def create
    puts quotation_params
  end

  private

  def quotation_params
    params.require(:quotation).permit(
      :status, :exchange_rate, :origin, :destination, :incoterm, client: [:name, :address],
      quotelineitems: [:description, :currency, :cost, :frequency, :quantity, :total]
    )
  end
end
