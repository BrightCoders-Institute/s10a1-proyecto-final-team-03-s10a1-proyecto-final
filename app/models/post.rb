class Post < ApplicationRecord
  belongs_to :user

  scope :user_post, ->(user) { where(user_id: user.id) }

  has_many_attached :images

  validates :body, presence: true
  validates :images,
            content_type: { in: %w[image/png image/jpg image/jpeg], message: 'must be images',
                            processable_image: true, aspect_ratio: :landscape }
end
