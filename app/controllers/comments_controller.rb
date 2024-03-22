class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: %i[create reply]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    set_parent_comment if params[:parent_comment_id].present?

    if @comment.save
      redirect_to post_path(@post), notice: 'Comment was successfully created'
    else
      redirect_to post_path(@post), alert: 'Failed to create comment!'
    end
  end

  def reply
    @parent_comment = Comment.find(params[:parent_comment_id])
    @comment = Comment.new(parent_comment: @parent_comment)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_comment_id)
  end

  def find_post
    @post = Post.find_by(id: params[:post_id])
    redirect_to root_path, alert: 'Post not found' unless @post
  end

  def set_parent_comment
    @parent_comment = Comment.find_by(id: params[:parent_comment_id])
    @comment.parent_comment = parent_comment if parent_comment
  end
end
