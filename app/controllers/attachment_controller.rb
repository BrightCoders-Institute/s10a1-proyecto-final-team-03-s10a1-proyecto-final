# frozen_string_literal: false

# controller attachment
class AttachmentController < ActionController::Base
  def purge
    attachment = ActiveStorage::Attachment.find(params[:id])
    attachment.purge
  end
end
