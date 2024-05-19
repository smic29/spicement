class Admin::CompaniesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_company, only: [ :show, :update ]

  def index
    @companies = Company.where(approved: false)
  end

  def show

  end

  def update

  end

  private

  def set_company
    @company = Company.find(params[:company])
  end
end
