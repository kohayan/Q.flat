class QuizzesController < ApplicationController
	before_action :set_quiz, only: [:show, :edit, :update, :destroy]
	before_action :ensure_correct_user, only: [:edit, :update, :destroy]
	before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

	def create
		@new_quiz = current_user.quizzes.new(quiz_params)
		if @new_quiz.save
			flash[:notice] = "クイズを投稿しました！"
			redirect_to quizzes_path
		else
			@quizzes = Quiz.all
			render :index
		end
	end

	def show
		@comment = QuizComment.new
		@comments = @quiz.quiz_comments
	end

	def index
		if params[:category]
			@quizzes = Quiz.where(category: params[:category])
		else
			@quizzes = Quiz.all
		end
	end

	def edit
	end

	def update
		if @quiz.update(quiz_params)
			flash[:notice] = "クイズを編集しました！"
			redirect_to quiz_path(@quiz)
		else
			render :show
		end
	end

	def destroy
		@quiz.destroy
		flash[:notice] = "クイズを削除しました！"
		redirect_to quizzes_path
	end


	private

	def set_quiz
		@quiz = Quiz.find(params[:id])
	end

	def quiz_params
		params.require(:quiz).permit(
			:question,
			:answer,
			:explanation,
			:quiz_image_id,
			:category
		)
	end

	def ensure_correct_user
		if @quiz.user_id != current_user.id
			flash[:notice] = "権限がありません"
			redirect_back(fallback_location: root_path)
		end
	end
end
