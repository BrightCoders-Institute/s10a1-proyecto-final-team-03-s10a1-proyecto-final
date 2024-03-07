class Post < ApplicationRecord
  belongs_to :user

  scope :user_post, ->(user) { where(user_id: user.id) }

end
