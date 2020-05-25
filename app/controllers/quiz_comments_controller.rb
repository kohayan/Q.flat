class QuizCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quiz

  def create
    @comment = @quiz.quiz_comments.new(quiz_comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      @quiz = @comment.quiz
      @quiz.create_notification_comment!(current_user, @comment.id, @quiz.user.id)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment = QuizComment.find(params[:id])
    if @comment.user_id != current_user.id
      redirect_back(fallback_location: root_path)
    end
    @comment.destroy
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def quiz_comment_params
    params.require(:quiz_comment).permit(:comment)
  end
end
