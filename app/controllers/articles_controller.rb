class ArticlesController < ApplicationController
  before_action :is_owner, only: [:edit, :update, :destroy]
  before_action :is_author, only: [:new, :create]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.find(current_user.id)

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def edit
      @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status, :user_id, :content)
    end

  private
    def is_owner
      @article = Article.find(params[:id])
      if !current_user.nil? && ( @article.user_id == current_user.id || current_user.is_admin )
      else
        redirect_to login_path, alert: "Not authorized"
      end
    end

  private
    def is_author
      if !current_user.nil? && ( current_user.is_admin || current_user.is_author)
      else
        redirect_to login_path, alert: "Not authorized"
      end
    end
end
