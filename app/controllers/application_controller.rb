class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :new_quiz
	before_action :notification
	before_action :categories

	protected

	def new_quiz
		@new_quiz = Quiz.new
	end

	def notification
		if user_signed_in?
			@notifications = current_user.passive_notifications.where.not(visitor_id: current_user.id)
		end
	end

	def categories
		@categories = Quiz.categories.keys
	end

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:nick_name, :email])
		devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
	end
end
