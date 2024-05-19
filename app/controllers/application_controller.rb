class ApplicationController < ActionController::Base
  def prepend_toast
    turbo_stream.prepend("toast_container", partial: 'shared/alerts')
  end

  private

  def authenticate_admin!
    authenticate_user!
    redirect_to root_path, alert: 'You are not authorized to access this page.' unless current_user.admin?
  end
end
