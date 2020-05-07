class Favorite < ApplicationRecord
	validdates :user, :quiz, presence: true

	belongs_to :users
	belongs_to :quizzes
end
