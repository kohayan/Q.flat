class Favorite < ApplicationRecord
	validdates :user, :quiz, presence: true

	belongs_to :user
	belongs_to :quiz
end
