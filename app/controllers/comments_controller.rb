class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic

  def create
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to article_url(@article)
    else
      render :template => "articles/show"
      # 因為是在comment頁面卻要抓article model所以要另外render
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
