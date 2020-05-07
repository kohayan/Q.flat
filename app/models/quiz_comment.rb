class QuizComment < ApplicationRecord
	validates :user, :quiz, :comment, presence: true

	belongs_to :users
	belongs_to :quizzes
end
