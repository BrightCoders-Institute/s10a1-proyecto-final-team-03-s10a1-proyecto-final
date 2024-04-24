class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @follow = User.where(id: current_user.id)
    @posts = @user.posts.order(created_at: :desc)

    # Filtramos los "me gusta" del usuario actual para las publicaciones del usuario en cuestión
    @user_likes = @user.likes.where(post_id: @posts.pluck(:id)).index_by(&:post_id)
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

  def user_params
    params.require(:user).permit(:name, :lastName, :birthday, :weight, :height, :email, :image_profile)
  end
end
