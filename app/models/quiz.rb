class Quiz < ApplicationRecord
	validates :user, :question, :answer, presence: true

	belongs_to :user
	has_many :quiz_categories
	has_many :quiz_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :categories, through: :quiz_categories

	attachment :quiz_image

	enum category: {謎解き:0, エンタメ:1, 雑学:2, 時事:3}

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	def create_notification_like!(current_user)
		temp = Notification.where(["visitor_id = ? and visited_id = ? and quiz_id = ? and action = ? ",
                          current_user.id, user_id, id, 'like'])
		if temp.blank?
			notification = current_user.active_notifications.new(
				quiz_id: id,
				visited_id: user_id,
				action: 'like'
			)

			if notification.visitor_id == notification.visited_id
				notification.checked = true
			end
			notification.save if notification.valid?
		end
	end

	def create_notification_comment!(current_user, comment_id, visited_id)
		notification = current_user.active_notifications.new(
			quiz_id: id,
			quiz_comment_id: comment_id,
			visited_id: visited_id,
			action: 'comment'
		)
		if notification.visitor_id == notification.visited_id
			notification.checked = true
		end
		notification.save if notification.valid?
	end
end
