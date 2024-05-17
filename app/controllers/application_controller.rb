class ApplicationController < ActionController::Base
  def prepend_toast
    turbo_stream.prepend("toast_container", partial: 'shared/alerts')
  end
end
