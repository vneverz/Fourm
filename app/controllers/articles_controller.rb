class ArticlesController < ApplicationController
   before_action :authenticate_user!, :only => [:new, :create, :destroy]
  def index
    @q = Article.ransack(params[:q])
    if params[:cid]
      category = Category.find(params[:cid])
      @articles = category.articles
    else
      @articles = Article.all
    end

    @q = @articles.ransack(params[:q])
    @articles = @q.result(distinct: true).page(params[:page])
  end

  def show
    @article = Article.find(params[:id])

    unless cookies["view-article-#{@article.id}"]
      cookies["view-article-#{@article.id}"] = "true"
      @article.view!
    end

    @comment = Comment.new

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

  def about

  end

  def destroy
    @article = Article.find(params[:id])

    if @article.can_delete_by?(current_user)
       @article.destroy
    end

    redirect_to articles_url
  end

  protected

  def article_params
    params.require(:article).permit(:title, :description, :category_ids => [])
  end
end
