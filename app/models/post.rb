class Post < ApplicationRecord
  belongs_to :user

  scope :user_post, ->(user) { where(user_id: user.id) }

  has_many_attached :images

  validates :body, presence: true
  validate :validate_at_least_one_image_attached
  validate :validate_image_content_type

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

  def validate_at_least_one_image_attached
    errors.add(:images, 'must be attached') unless images.attached?
  end

  def validate_image_content_type
    images.each do |image|
      unless image.content_type.in?(['image/jpg', 'image/png', 'image/jpeg'])
        errors.add(:images, 'must be a valid image format (PNG, JPG, JPEG)')
      end
    end
  end
end
