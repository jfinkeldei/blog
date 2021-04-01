class UsersController < ApplicationController
  before_action :authorize, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url, notice: "Thank you for signing up!"
    else
      render "new"
    end
  end

  def show
    @user = User.find(current_user.id)
    @articles = Article.where(:user_id => current_user.id)
  end

  private
  def user_params
    params[:user].permit(:email, :password, :password_confirmation)
  end
end
