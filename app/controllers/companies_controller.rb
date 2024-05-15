class CompaniesController < ApplicationController
  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      flash[:notice] = "Application Submitted"
      respond_to do |format|
        format.html { redirect_to application_success_path }
        format.turbo_stream { render turbo_stream: [
          turbo_stream.update("auth_frame", template: "companies/success")
        ]}
      end
    else
      flash[:alert] = "Cannot Proceed with application"
      render :new, status: :unprocessable_entity
    end
  end

  def success
    @company = Company.find(params[:id])
  end

  private

  def company_params
    params.require(:company).permit(:name, :email)
  end
end
