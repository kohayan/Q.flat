class Quiz < ApplicationRecord
	validates :user, :question, :answer, presence: true

	belongs_to :user
	has_many :quiz_categories
	has_many :quiz_comments
	has_many :favorites
	has_many :categories, through: :quiz_categories
end
