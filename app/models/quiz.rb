class Quiz < ApplicationRecord
	validates :user, :question, :answer, presence: true

	belongs_to :user
	has_many :quiz_categories
	has_many :quiz_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :categories, through: :quiz_categories

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
end
