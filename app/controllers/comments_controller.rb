class CommentsController < ApplicationController
  before_action :authorize, only: [:create]
  before_action :is_owner, only: [:destroy]

  def create
    @article = Article.find(params[:article_id])

    @comment = @article.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save

    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :status)
    end

  private
    def is_owner
      @article = Article.find(params[:article_id])
      @comment = @article.comments.find(params[:id])
      if !current_user.nil? && ( @comment.user_id == current_user.id || current_user.is_admin || @article.user_id == current_user.id)
      else
        redirect_to login_path, alert: "Not Authorized"
      end
    end
end
