class SearchController < ApplicationController
  before_action :authenticate_user!

  def new
    @users = User.all
    @posts = Post.all
    render json: { users: @users, posts: @posts }
  end

  def index; end
end
