class CompaniesController < ApplicationController
  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      flash[:notice] = "Application Submitted"
      respond_to do |format|
        format.html { redirect_to success_new_company_path(@company) }
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

    redirect_to search_companies_path if @company.approved
  end

  def search
    @fail = params[:fail] || false
  end

  def verify
    company = Company.find_by(company_code: params[:company_code].upcase)

    if company&.approved
      redirect_to new_user_session_path(id: company.id)
    elsif company && company.approved == false
      verification_response("Company has not been approved", params[:company_code])
    else
      verification_response("Invalid Company Code", params[:company_code])
    end
  end

  private

  def verification_response(msg, company_code)
    flash[:alert] = msg
    @fail = company_code
    respond_to do |format|
      format.html { render :search, status: :unprocessable_entity }
      format.turbo_stream { render turbo_stream: [
        turbo_stream.update("auth_frame", template: 'companies/search'),
        prepend_toast
      ]}
    end
  end

  def company_params
    params.require(:company).permit(:name, :email)
  end
end
