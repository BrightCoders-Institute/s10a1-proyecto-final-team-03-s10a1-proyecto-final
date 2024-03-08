class Post < ApplicationRecord
  belongs_to :user

  scope :user_post, ->(user) { where(user_id: user.id) }

  has_one_attached :post_image
end
