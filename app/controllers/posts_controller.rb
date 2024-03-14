class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show destroy edit update]
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

  def edit; end

  def update
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
    @post.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Post was succesfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.user_post(current_user).find(params[:id])
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
