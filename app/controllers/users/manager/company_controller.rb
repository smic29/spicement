class Users::Manager::CompanyController < ApplicationController
  before_action :authenticate_manager!, :set_company

  def edit

  end

  def show

  end

  def update
    if company_params[:logo]
      @company.logo.attach(company_params[:logo])
      company_params.delete(:logo)
    end

    if @company.update(company_params)
      render :show
    else
      render :edit
    end
  end

  private

  def set_company
    @company = current_user.company
  end

  def company_params
    params.require(:company).permit(:logo, :name, :address, :contact_number)
  end
end
