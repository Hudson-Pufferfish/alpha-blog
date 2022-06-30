class ArticlesController < ApplicationController
  before_action :set_article, only: [:show,:edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def show
    # @article = Article.find(params[:id]) #Instance variable
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def create 
    # render plain: params[:article]
    @article = Article.new(article_params)
    @article.user = current_user
    # render plain: @article.inspect
    if @article.save
      flash[:notice] = "Article was created successfully"
      redirect_to article_path(@article)
    # OR redirect_to @article
    else
      render 'new'
    end
  end
  
  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = 'Article was updated successfully'
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  
  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private 

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user
      flash[:alert] = "You can only edit or delete your own article"
      redirect_to @article
    end
  end


end