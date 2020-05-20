class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
		   :recoverable, :rememberable, :validatable

	validates :nick_name, presence: true
	validates :nick_name, length:{in: 2..20}
	validates :introduction, length: {maximum:49}

	has_many :quizzes, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :favorite_quizzes, through: :favorites, source: :quiz
	has_many :quiz_comments, dependent: :destroy
	has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
	has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
	has_many :following_user, through: :follower, source: :followed
	has_many :follower_user, through: :followed, source: :follower
	has_many :active_notifications, foreign_key:"visitor_id", class_name: "Notification", dependent: :destroy
	has_many :passive_notifications, foreign_key:"visited_id", class_name: "Notification", dependent: :destroy
	has_many :impressions, dependent: :destroy

	attachment :image

	def follow(user_id)
		follower.create(followed_id: user_id)
	end

	def unfollow(user_id)
		follower.find_by(followed_id: user_id).destroy
	end

	def following?(user)
		following_user.include?(user)
	end

	def create_notification_follow!(current_user)
		notification = current_user.active_notifications.new(
			visited_id: id,
			action: 'follow'
		)
		notification.save if notification.valid?
	end
end
