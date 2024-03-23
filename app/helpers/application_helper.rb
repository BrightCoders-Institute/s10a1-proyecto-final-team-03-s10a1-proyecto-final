module ApplicationHelper
  def image_profile?(resize = nil)
    return 'avatar-default.webp' unless current_user.image_profile.attached?

    return current_user.image_profile.representation(resize_to_limit: resize) unless resize.nil?

    current_user.image_profile
  end
end
