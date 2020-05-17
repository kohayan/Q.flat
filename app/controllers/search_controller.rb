class SearchController < ApplicationController

	def search
		@users = User.where(['nick_name LIKE ?', "%#{params[:keyword]}%"])
		@quizzes = Quiz.where(['question LIKE ?', "%#{params[:keyword]}%"])
	end
end
