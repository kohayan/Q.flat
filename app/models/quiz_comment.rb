class QuizComment < ApplicationRecord
	validates :user, :quiz, :comment, presence: true

	belongs_to :user
	belongs_to :quiz

	default_scope -> { order(created_at: :desc) }
end
