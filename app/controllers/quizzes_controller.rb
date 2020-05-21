class QuizzesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def create
    @new_quiz = current_user.quizzes.new(quiz_params)
    tag_list = params[:quiz][:tag_list].split(",")
    if @new_quiz.save
      @new_quiz.save_tags(tag_list)
      flash[:notice] = "クイズを投稿しました！"
      redirect_to home_users_path
    else
      @quizzes = Quiz.all
      render :index
    end
  end

  def show
    @comment = QuizComment.new
    @comments = @quiz.quiz_comments.date
    if user_signed_in?
      @quiz.create_impression(current_user)
    end
  end

  def index
    if params[:category]
      @quizzes = Quiz.where(category: params[:category]).date
    elsif params[:tag]
      tag = Tag.find(params[:tag])
      @quizzes = tag.quizzes.date
    else
      @quizzes = Quiz.all.date
    end
  end

  def edit
    @tag_list = @quiz.tags.pluck(:name).join(",")
  end

  def update
    tag_list = params[:quiz][:tag_list].split(",")
    if @quiz.update(quiz_params)
      @quiz.save_tags(tag_list)
      flash[:notice] = "クイズを編集しました！"
      redirect_to quiz_path(@quiz)
    else
      render :edit
    end
  end

  def destroy
    @quiz.destroy
    flash[:notice] = "クイズを削除しました！"
    redirect_to user_path(@quiz.user)
  end

  def famous
    @impression_ranks = Quiz.impression_rank
    @favorite_ranks = Quiz.favorite_rank
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
