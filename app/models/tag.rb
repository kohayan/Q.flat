class Tag < ApplicationRecord
  validates :name, presence: true

  has_many :quiz_tags, dependent: :destroy
  has_many :quizzes, through: :quiz_tags

  scope :date, -> { order(created_at: :desc) }
end
