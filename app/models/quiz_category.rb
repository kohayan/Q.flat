class QuizCategory < ApplicationRecord
	validates :quiz, :category, presence: true

	belongs_to :quiz
	belongs_to :category
end
