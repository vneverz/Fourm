class ArticlesController < ApplicationController
   before_action :authenticate_user!, :only => [:new, :create, :destroy]
  def ajaxtest
    respond_to do |format|
      format.html { render :layout => false }
      format.js
      format.json { render :json => { :title => "TITLE", :description => "CONTENT" }.to_json }
    end
  end

  def index
    @q = Article.ransack(params[:q])

    if params[:cid&& params[:cid] != "0"]
      category = Category.find(params[:cid])
      @articles = category.articles
    elsif params[:cid] == "0"
      @articles = Article.joins("LEFT OUTER JOIN article_categories ON articles.id = article_categories.article_id").group("articles.id").having("count(article_categories.category_id) = 0")
    else
      @articles = Article.all
    end
    @articles = @articles.only_published(current_user)

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
    params.require(:article).permit(:title, :description, :status, :category_ids => [])
  end
end
