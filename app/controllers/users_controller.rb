class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @user = User.find(params[:id])
    @follow = User.where(id: current_user.id)
    @posts = @user.posts.order(created_at: :desc)
    @user_likes = @user.likes.where(post_id: @posts.pluck(:id)).index_by(&:post_id)
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])

    @stories = @user.stories.order(created_at: :desc)

    stories_json = @stories.map do |story|
      {
        user_id: @user.id,
        id: story.id,
        name: story.body,
        day: story.day,
        images: story.images.attached? ? rails_blob_path(story.images.first, only_path: true) : nil
      }
    end

    render json: { stories: stories_json }
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

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :lastName, :birthday, :weight, :height, :email, :image_profile)
  end
end
