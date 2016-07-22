class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_filter :set_browser
  
  def set_browser
    @browser = Browser.new(request.env["HTTP_USER_AGENT"])
  end

  def authenticate_admin!
    unless current_user and current_user.is_admin?
      redirect_to root_path
    end
  end
end
