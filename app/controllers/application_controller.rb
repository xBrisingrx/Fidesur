class ApplicationController < ActionController::Base

	# def default_url_options
	#   { locale: I18n.locale }
	# end

	helper_method :current_user, :logged_in?
  before_action :no_login

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
