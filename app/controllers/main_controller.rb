class MainController < ApplicationController
  before_action :authenticate_user!
  def home
    @posts = Post.all
  end
end
