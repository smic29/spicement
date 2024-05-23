class Users::QuotationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @quotation = current_user.quotations.new
  end

  def create

  end
end
