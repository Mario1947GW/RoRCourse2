class SessionsController < ApplicationController

  def new
    redirect_to articles_path if logged_in?
  end

  def create
    user = User.find_by(:email => params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Zalogowano sie pomyślnie"
      redirect_to user
    else
      flash.now[:alert] = "Niepoprawne dane logowania"
      render 'new'
    end
  end

  def destroy
    return redirect_to articles_path if !logged_in?
    session[:user_id] = nil
    flash[:notice] = "Wylogowano się"
    redirect_to root_path
  end

end