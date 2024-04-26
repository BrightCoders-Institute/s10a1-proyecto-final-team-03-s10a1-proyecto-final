class StreaksController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @streak = @user.streak
  end
end
