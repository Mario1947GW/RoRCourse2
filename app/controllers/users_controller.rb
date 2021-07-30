require 'bcrypt'
class UsersController < ApplicationController
  
  before_action :find_user_from_params_id, only: [:show, :edit, :update, :destroy]

  def show
    @articles = @user.articles
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(get_user_params)
    if @user.save
      flash[:notice] = "Pomyślnie zarejestrowano użytkownika"
      redirect_to root_path
    else
      render 'new'    
    end
  end

  def update
    find_user_from_params_id
    if @user.update(get_user_params)
      flash[:notice] = "Pomyślnie zmodyfikowano dane użytkownika"
      redirect_to edit_user_path
    else
      render 'edit'
    end
  end

  def get_user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def find_user_from_params_id
    @user = User.find(params[:id])
  end

end