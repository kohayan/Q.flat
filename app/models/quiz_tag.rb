class QuizTag < ApplicationRecord
	validates :quiz, :tag, presence: true

	belongs_to :quiz
	belongs_to :tag
end
