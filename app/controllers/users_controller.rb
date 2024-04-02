class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.where(params[id: @user])
    @users = User.all
    @follow = User.where(user_id: current_user.id)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.save
  end

  def update
    @user = current_user.update(user_params)
    redirect_to posts_path
  end

  private

  def set_post
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :lastName, :birthday, :weight, :height, :email, :image_profile)
  end
end
