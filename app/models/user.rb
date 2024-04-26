# frozen_string_literal: false

class User < ApplicationRecord
  has_one_attached :image_profile
  has_one  :streak
  has_many :posts
  has_many :followers, foreign_key: 'user_id', dependent: :destroy
  has_many :following, foreign_key: 'follower_user_id', class_name: 'Follower', dependent: :destroy
  has_many :likes
  has_many :comments
  has_many :routines

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

  def increment_followers
    increment!(:followers_count)
  end

  def decrement_followers
    decrement!(:followers_count)
  end

  def update_streak_if_needed
    update_streak if needs_streak_update?
  end

  def needs_streak_update?
    return false if streak.nil? || streak.last_login_date == Date.today

    streak.last_login_date != Date.today
  end

  def update_streak
    if streak.nil?
      Streak.create(user: self, current_streak: 1, longest_streak: 1, last_login_date: Date.today)
    elsif streak.last_login_date == Date.today - 1
      current_streaks
    elsif streak.last_login_date < Date.today - 1
      reset_streak
    end
  end

  def current_streaks
    streak.update(current_streak: streak.current_streak + 1,
                  longest_streak: [streak.longest_streak, streak.current_streak + 1].max,
                  last_login_date: Date.today)
  end

  def reset_streak
    streak&.update(current_streak: 1, last_login_date: Date.today)
  end
end
