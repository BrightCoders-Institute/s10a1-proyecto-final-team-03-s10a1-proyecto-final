class Routine < ApplicationRecord
  belongs_to :user

  has_many :series

  validates :exercise, presence: true
end
