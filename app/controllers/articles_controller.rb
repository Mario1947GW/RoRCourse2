class ArticlesController < ApplicationController
  
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update, :new,:destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def show
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(get_article)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Pomyślnie zapisano artykuł" 
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    if @article.update(get_article)
      @article.user = current_user
      flash[:notice] = "Pomyślnie zmieniono artykuł" 
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    if @article.destroy
      flash[:notice] = "Pomyślnie usunięto artykuł"
      redirect_to articles_path
    else
      render 'index'
    end
  end

  private 

  def set_article
    @article = Article.find(params[:id])
  end

  def get_article
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      redirect_to articles_path
    end
  end

end
