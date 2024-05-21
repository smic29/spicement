# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication, only: [:new, :create]
  before_action :authenticate_manager!
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    # super
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        respond_to do |format|
          format.html { redirect_to root_path, notice: "User successfully created" }
          flash[:notice] = "User successfully created"
          format.turbo_stream { render turbo_stream: [
            turbo_stream.replace("users_frame") {
              "<turbo-frame id='users_frame' src='#{root_path}'></turbo-frame>".html_safe
            },
            prepend_toast
          ]}
        end
      else
        # TODO: Check what conditions would trigger this codeblock
        respond_to do |format|
          flash[:alert] = "I am experimenting on this and have no idea when this would proc"
          format.html { redirect_to root_path }
          format.turbo_stream { render turbo_stream: [
            turbo_stream.replace("users_frame", template: "users/dashboard/index"),
            prepend_toast
          ]}
        end
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:company_id, :first_name, :last_name])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    # super(resource)
    root_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
