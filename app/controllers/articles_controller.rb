class ArticlesController < ApplicationController
  def index
    @articles = Article.page(params[:page])
  end
end
