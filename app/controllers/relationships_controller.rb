class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    current_user.follow(@user.id)
    @user.create_notification_follow!(current_user)
  end

  def destroy
    current_user.unfollow(@user.id)
  end

  def follower
    @follows = @user.following_user
    @followers = @user.follower_user
  end

  def followed
    @follows = @user.following_user
    @followers = @user.follower_user
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
