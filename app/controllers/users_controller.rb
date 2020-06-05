class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:home, :edit, :update]
  before_action :set_user, except: [:home]
  before_action :ensure_correct_user, only: [:edit, :update]

  def home
    users = current_user.following_user
    @quizzes = Quiz.where(user_id: users).or(Quiz.where(user_id: current_user.id)).date
  end

  def show
    @quizzes = @user.quizzes.date
    @favorites = @user.favorite_quizzes.date
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:notice] = "ユーザーが存在しません"
      redirect_to quizzes_path
    end
  end

  def user_params
    params.require(:user).permit(:nick_name, :email, :introduction, :image)
  end

  def ensure_correct_user
    if @user.id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_back(fallback_location: root_path)
    end
  end
end
