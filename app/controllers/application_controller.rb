class ApplicationController < ActionController::Base
  
  helper_method :current_user, :logged_in?, :current_user_admin?
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def require_user
    if !logged_in?
      flash[:alert] = "Strona wymaga zalogowania"
      redirect_to login_path
    end
  end

  def current_user_admin?
    return true if current_user.admin == "admin" 
    return false if current_user.admin == 'user'  
  end

end
