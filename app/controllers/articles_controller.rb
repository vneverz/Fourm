class ArticlesController < ApplicationController
   before_action :authenticate_user!, :only => [:new, :create, :destroy]
  def index
    @articles = Article.page(params[:page])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      redirect_to articles_url
    else
      render :new
    end
  end

  protected

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
