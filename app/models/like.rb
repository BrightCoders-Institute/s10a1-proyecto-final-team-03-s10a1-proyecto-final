class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def new
    @like = Like.new
  end

  def increment_post_likes
    post.increment!(:likes_count)
  end

  def decrement_post_likes
    post.decrement!(:likes_count)
  end
end
