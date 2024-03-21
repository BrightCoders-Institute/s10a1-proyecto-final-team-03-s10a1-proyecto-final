class PostsController < ApplicationController
  before_action :set_post, only: %i[show destroy edit update]
  before_action :authenticate_user!, except: %i[show index]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: 'Post created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @posts = current_user.posts.order(created_at: :desc)
    @user_likes = current_user.likes.where(post_id: @posts.map(&:id)).index_by(&:post_id)
  end

  def edit
    unless current_user == @post.user
      redirect_to root_path, alert: 'You are not authorized to edit this post.'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def update
    unless current_user == @post.user
      redirect_to root_path, alert: 'You are not authorized to update this post.'
    end

    respond_to do |format|
      if @post.update(post_params)
        update_status(format)
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    unless current_user == @post.user
      redirect_to root_path, alert: 'You are not authorized to delete this post.'
    end

    @post.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Post was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:body, images: [], images_to_remove: [])
  end

  def update_status(format)
    @post.remove_images if @post.persisted? && post_params[:images_to_remove].present?

    format.html { redirect_to root_path, notice: 'Post was successfully updated.' }
    format.json { render :show, status: :ok, location: @post }
  end
end
