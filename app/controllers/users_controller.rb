require 'bcrypt'
class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(get_user)
    if @user.save
      flash[:notice] = "Pomyślnie zarejestrowano użytkownika"
      redirect_to root_path
    else
      render 'new'    
    end
  end

  def get_user
    params.require(:user).permit(:username, :email, :password)
  end

end