class Admin::DashboardController < ApplicationController
  before_action :authenticate_admin!

  def index
    @companies = Company.all

  end
end
