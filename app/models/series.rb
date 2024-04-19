class Series < ApplicationRecord
  belongs_to :routine

  has_many :exercises

  validates :name, presence: true
end
