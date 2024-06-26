class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :show_themself, only: %i[show]
  before_action :set_user

  def index
  end

  def show
    load_users
    load_social_actions
  end

  def chat
    load_users
    @message = Message.new
    @messages = load_user_messages(@user, current_user)
    render 'chats/index'
  end

  def new
    @user = User.new
  end

  def json
    @users = User.all

    stories_json = @users.flat_map do |user|
      user.stories.order(created_at: :desc).map do |story|
        {
          user_id: user.id,
          id: story.id,
          name: story.body,
          day: story.day,
          images: story.images.attached? ? rails_blob_path(story.images.first, only_path: true) : nil
        }
      end
    end

    render json: { stories: stories_json }
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

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :lastName, :birthday, :weight, :height, :email, :image_profile)
  end

  def load_users
    @user = User.find(params[:id])
    @users = User.all_except(current_user)
  end

  def load_social_actions
    @follow = User.where(id: current_user.id)
    @posts = @user.posts.order(created_at: :desc)
    @user_likes = current_user.likes.where(post_id: @posts.map(&:id)).index_by(&:post_id)
  end

  def load_user_messages(user1, user2)
    @room_name = get_name(user1, user2)
    @single_room = Room.where(name: @room_name).first || Room.create_private_room([user1, user2], @room_name)
    @single_room.messages.order(created_at: :asc)
  end

  def get_name(user1, user2)
    user = [user1, user2].sort
    "private_#{user[0].id}_#{user[1].id}"
  end

  def show_themself
    redirect_to posts_path if current_user.id == params[:id].to_i
  end
end
