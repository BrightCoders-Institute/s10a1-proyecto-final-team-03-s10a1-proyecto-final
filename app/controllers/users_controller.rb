class UsersController < ApplicationController
  before_action :authenticate_user!

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    @user.save
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    @user = current_user.update(user_params)
    redirect_to posts_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :lastName, :birthday, :weight, :height, :email, :image_profile)
  end
end
