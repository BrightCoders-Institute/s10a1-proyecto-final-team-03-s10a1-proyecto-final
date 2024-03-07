class Message < ApplicationRecord
  belongs_to :user
  belongs_to :message_parent
  has_one_attached :image_message
end
