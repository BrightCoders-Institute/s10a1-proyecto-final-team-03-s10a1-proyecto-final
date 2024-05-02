class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
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

  def edit; end

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
end
