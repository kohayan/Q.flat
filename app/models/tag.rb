class Tag < ApplicationRecord
	valadates :name, presence: true

	has_many :quiz_tags, dependent: :destroy
	has_many :quizzes, through: :quiz_tag
end
