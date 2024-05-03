class Story < ApplicationRecord
  belongs_to :user

  has_many_attached :images
  has_rich_text :body

  validates :body, presence: true
  validates :images,
            content_type: { in: %w[image/png image/jpg image/jpeg], message: 'must be an image',
                            processable_image: true, aspect_ratio: :landscape }
end
