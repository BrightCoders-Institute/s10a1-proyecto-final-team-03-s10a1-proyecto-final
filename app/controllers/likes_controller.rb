class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.new(post_id: params[:post_id])
    if @like.save
      @like.increment_post_likes
      redirect_back fallback_location: root_path, notice: 'Like added!'
    else
      redirect_back fallback_location: root_path, alert: 'Failed to add like!'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_by(user_id: current_user.id)
    if @like.destroy
      @like.decrement_post_likes
      redirect_back fallback_location: root_path, notice: 'Like removed!'
    else
      redirect_back fallback_location: root_path, alert: 'Failed to remove like!'
    end
  end
end
