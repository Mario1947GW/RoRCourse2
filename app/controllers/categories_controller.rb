class CategoriesController < ApplicationController
  before_action :require_admin
  before_action :find_category_by_params_id, only: [:show, :edit, :update, :destroy]
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def show

  end

  def edit
    
  end
  
  def create
    @category = Category.new(get_category_params)
    if @category.save
      flash[:notice] = "Kategoria została pomyślnie dodana"
      redirect_to @category
    else
      render 'new'
    end
  end

  def update
  end

  def destroy
  end

  private
  
  def get_category_params
    params.require(:category).permit(:name)
  end

  def find_category_by_params_id
    @category = Category.find(params[:id])
  end
  
  def require_admin
    redirect_to articles_path if !(logged_in? && current_user.admin?) || !logged_in?
  end

end