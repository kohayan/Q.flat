class UsersController < ApplicationController
	before_action :set_user
	before_action :ensure_correct_user, only: [:edit, :update]

	def show
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
		@user = User.find(params[:id])
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
