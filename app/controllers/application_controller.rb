class ApplicationController < ActionController::Base


	helper_method :current_user, :logged_in?
  before_action :no_login
  before_action :default_url_options

  config.time_zone = "America/Argentina/Buenos_Aires"

	def default_url_options
	  { locale: I18n.locale }
	end

	def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def logged_in?
    !!current_user
  end

  def no_login
    if !logged_in?
      redirect_to login_path
    end
  end
  
end
