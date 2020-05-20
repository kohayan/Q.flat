class SearchController < ApplicationController

	def search
		@quizzes = Quiz.where(['question LIKE ?', "%#{params[:keyword]}%"]).date
		@users = User.where(['nick_name LIKE ?', "%#{params[:keyword]}%"]).date
		@tags = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"]).date
	end
end
