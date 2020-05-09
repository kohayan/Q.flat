class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :new_quiz

	protected

	def new_quiz
		@new_quiz = Quiz.new
	end

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:nick_name, :email])
		devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
	end
end
