class Exercise < ApplicationRecord
  belongs_to :series

  validates :repetitions, presence: true
end
