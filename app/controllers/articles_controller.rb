class ArticlesController < ApplicationController
  before_action :authorize, only: [:edit, :update, :new, :create, :destroy]

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
    if @article.user_id == current_user.id
      @article.destroy
    end

    redirect_to root_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status, :user_id)
    end
end
