class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id]) #Instance variable
  end

  def index
    @articles = Article.all
  end
end