class MainController < ApplicationController
  before_action :authenticate_user!
  def home
    @posts = Post.all.order(created_at: :desc)
    @user_likes = current_user.likes.where(post_id: @posts.map(&:id)).index_by(&:post_id)
    @stories = Story.all.order(created_at: :desc)
    @users = User.all.order(created_at: :desc)
  end
end
