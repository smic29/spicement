# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    id = params[:id] || params.dig(:user, :company_id)
    @company = Company.find(id)
    if @company&.approved
      super
    else
      flash[:alert] = "User login is not allowed yet"
      redirect_to search_companies_path(fail: @company.company_code)
    end
  end

  # POST /resource/sign_in
  def create
    company_id = params.dig(:user, :company_id)
    @company = Company.find(company_id)

    unless @company.approved
      redirect_to new_user_session_path(id: @company.id) and return
    end

    self.resource = warden.authenticate!(auth_options)
    if resource && resource.active_for_authentication?
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      # Nothing really gets triggered here. It's weird
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:company_id])
  end

  def after_sign_in_path_for(resource)
    root_path
  end
end
