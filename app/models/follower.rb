class Follower < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :follower_user, class_name: 'User', foreign_key: 'follower_user_id'
  validates :user_id, uniqueness: { scope: :follower_user_id }

  def new
    @follow = Follow.new
  end

  def increment_following
    user.increment!(:following_count)
  end

  def decrement_following
    user.decrement!(:following_count)
  end
end
