class CommentsController < ApplicationController
  before_action :authorize, only: [:create, :destroy]

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
    if @comment.user_id == current_user.id
      @comment.destroy
    end
    redirect_to article_path(@article)

  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :status)
    end
end
