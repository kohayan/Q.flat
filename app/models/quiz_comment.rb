class QuizComment < ApplicationRecord
  validates :user, :quiz, :comment, presence: true
  validates :comment, length: { maximum: 140 }

  belongs_to :user
  belongs_to :quiz
  has_many :notifications, dependent: :destroy

  scope :date, -> { order(created_at: :desc) }
end
