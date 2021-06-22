class SessionsController < ApplicationController
  skip_before_action :no_login
  def new
    if logged_in?
      redirect_to root_path
    else
      @title = 'Iniciar sesion'
      respond_to do |format|
        format.html
      end
    end
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Sessión iniciada!"
    else
      flash.now[:alert] = "Nombre de usuario o contraseña invalido"
      render "new"
    end
  end  

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
