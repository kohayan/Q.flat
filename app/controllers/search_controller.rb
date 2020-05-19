class SearchController < ApplicationController

	def search
		@users = User.where(['nick_name LIKE ?', "%#{params[:keyword]}%"].date
		@quizzes = Quiz.where(['question LIKE ?', "%#{params[:keyword]}%"]).date
	end
end
