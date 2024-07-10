class Admin::CompaniesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_company, only: [ :show, :update ]

  def index
    @companies = Company.where(approved: false)
  end

  def show

  end

  def update
    service = Admin::ApprovalService.new(@company)

    if service.call
      respond_to do |format|
        @companies = Company.where(approved: false)
        flash[:notice] = "Company Approved. User Created. Email Sent"
        format.html { redirect_to root_path }
        format.turbo_stream { render turbo_stream: [
          turbo_stream.update("admin_frame", template: 'admin/companies/index'),
          prepend_toast
        ]}
      end
    end
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end
end
