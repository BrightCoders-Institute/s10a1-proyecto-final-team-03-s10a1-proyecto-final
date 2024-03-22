class FollowersController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    @follow = current_user.followers.new(follower_user_id: params[:user_id])
    if @follow.save
      @follow.increment_following
      @user.increment_followers

      redirect_back fallback_location: root_path, notice: 'Follow added!'
    else
      redirect_back fallback_location: root_path, alert: 'Failed to add follow!'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @follow = @user.followers.find_by(user_id: current_user.id)
    @follow.decrement_follow if @follow.destroy
  end

  def follower_params
    params.require(:follower).permit(:user_id, :follower_user_id)
  end
end
