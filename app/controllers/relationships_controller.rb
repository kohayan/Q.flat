class RelationshipsController < ApplicationController
	before_action :set_user
	before_action :authenticate_user!

	def create
		current_user.follow(@user.id)
		@user.create_notification_follow!(current_user)
		redirect_back(fallback_location: root_path)
	end

	def destroy
		current_user.unfollow(@user.id)
		redirect_back(fallback_location: root_path)
	end

	def follower
		@users = @user.following_user
	end

	def followed
		@users = @user.follower_user
	end


	private

	def set_user
		@user = User.find(params[:user_id])
	end
end
