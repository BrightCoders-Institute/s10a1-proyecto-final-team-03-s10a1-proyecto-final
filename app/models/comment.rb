class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :parent_comment
  has_one_attached :image_comment
end
