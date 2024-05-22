class Users::ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [ :show, :edit, :update ]

  def show

  end

  def edit

  end

  def update
    if @user.update(user_params)
      respond_to do |format|
        flash[:notice] = "Profile Updated"
        format.html { redirect_to users_profile_path }
        format.turbo_stream { render turbo_stream: [
          prepend_toast,
          turbo_stream.replace("users_frame", template: "users/profile/show")
        ]}
      end
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
