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
    @posts = Post.user_post(current_user)
  end

  def edit
    return if current_user == @post.user

    redirect_to root_path, alert: 'You are not authorized to edit this post.'
  end

  def show
    @post = Post.find(params[:id])
  end

  def update
    unless current_user == @post.user
      redirect_to root_path, alert: 'You are not authorized to update this post.'
      return
    end
    @post.update(post_params)
    redirect_to posts_path
  end

  def destroy
    unless current_user == @post.user
      redirect_to root_path, alert: 'You are not authorized to delete this post.'
      return
    end

    @post.destroy
  end

  def destroy_images
    @post = Post.find(params[:id])
    @post.images.each { image.destroy }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:body, images: [])
  end
end
