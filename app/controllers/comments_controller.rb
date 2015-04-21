class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic

  def create
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to article_url(@article) }
        format.js
      else
        format.html { render :template => "articles/show" }
        format.js
      end
    end
  end

  def destroy
    @comment = @article.comments.find( params[:id] )

    if @comment.can_delete_by?(current_user)
      @comment.destroy
    end

     respond_to do |format|
     format.html { redirect_to :back }
     format.js
    end
  end


  protected

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_topic
    @article = Article.find(params[:article_id])
  end
end
