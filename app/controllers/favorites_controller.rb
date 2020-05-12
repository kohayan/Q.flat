class FavoritesController < ApplicationController
	before_action :set_quiz

	def create
		@favorite = @quiz.favorites.new(user_id: current_user.id)
		@favorite.save
		@quiz.create_notification_like!(current_user)
	end

	def destroy
		@favorite = @quiz.favorites.find_by(user_id: current_user.id)
		@favorite.destroy
	end


	private

	def set_quiz
		@quiz = Quiz.find(params[:quiz_id])
	end
end
