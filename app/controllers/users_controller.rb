require 'bcrypt'
class UsersController < ApplicationController
  
  before_action :find_user_from_params_id, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    redirect_to articles_path if logged_in?
    @user = User.new
  end

  def edit
    redirect_to articles_path if current_user != @user
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
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Pomyślnie usunięto profil"
    redirect_to articles_path
  end

  private
  
  def get_user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def find_user_from_params_id
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      redirect_to articles_path
    end
  end

end