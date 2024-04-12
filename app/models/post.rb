class Post < ApplicationRecord
  belongs_to :user

  scope :user_post, ->(user) { where(user_id: user.id) }

  has_many :likes
  has_many :comments
  has_many_attached :images
  has_rich_text :body  

  validates :body, presence: true
  validates :images,
            content_type: { in: %w[image/png image/jpg image/jpeg], message: 'must be an image',
                            processable_image: true, aspect_ratio: :landscape }

  attr_accessor :images_to_remove

  def remove_images
    return unless images_to_remove.present?

    images_to_remove.each do |signed_id|
      next unless signed_id.present?

      select_image(signed_id)
    end
  end

  private

  def select_image(img_id)
    blob_id = ActiveStorage::Blob.find_signed!(img_id).id
    image = ActiveStorage::Attachment.find_by(blob_id: blob_id)
    image.purge if image.present?
  end
end
