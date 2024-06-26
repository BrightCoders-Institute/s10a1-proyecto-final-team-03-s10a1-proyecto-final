class FollowersController < ApplicationController
  before_action :authenticate_user!, :set_user, only: %i[create destroy]

  def create
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
    @follow = current_user.followers.find_by(follower_user_id: @user.id)

    if @follow.destroy
      @follow.decrement_following
      @user.decrement_followers

      redirect_back fallback_location: root_path, notice: 'Unfollow added!'
    else
      redirect_back fallback_location: root_path, alert: 'Failed to add unfollow!'
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
