# frozen_string_literal: false

class User < ApplicationRecord
  has_one_attached :image_profile
  has_many :posts
  has_many :likes
  has_many :comments

  validates :image_profile,
            content_type: { in: %w[image/png image/jpg image/jpeg], message: 'must be an image',
                            processable_image: true, aspect_ratio: :landscape }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: %i[google_oauth2]

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.find_or_initialize_by(email: data['email'])

    unless user.persisted?
      user.name = data['name']
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
      user.save
    end
    user
  end
end
