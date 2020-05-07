class Category < ApplicationRecord
	validates :name, presence: true

	has_many :quiz_categorieszs
	has_many :quizzes, through: :quiz_categories
end
