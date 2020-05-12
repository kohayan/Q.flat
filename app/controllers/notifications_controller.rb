class NotificationsController < ApplicationController

	def index
		@notifications.where(checked: false).each do |notification|
			notification.update_attributes(checked: true)
		end
	end

	def destroy_all
		current_user.passive_notifications.destroy_all
	end
end
