class Quiz < ApplicationRecord
  validates :user, :question, :answer, presence: true
  validates :question, :explanation, length: { maximum: 500 }
  validates :answer, length: { maximum: 200 }

  belongs_to :user
  has_many :quiz_tags, dependent: :destroy
  has_many :tags, through: :quiz_tags
  has_many :quiz_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :impressions, dependent: :destroy

  attachment :quiz_image

  enum category: {
    謎解き: 0, エンタメ: 1, 雑学: 2, 時事: 3, ことば: 4,
    すうじ: 5, 科学: 6, 英語: 7, 歴史: 8, 音楽: 9, その他: 10,
  }

  scope :date, -> { order(created_at: :desc) }

  scope :impression_rank, -> {
    find(Impression.where(['created_at LIKE ?', "%#{Date.today}%"]).group(:quiz_id).order('count(quiz_id) desc').limit(20).pluck(:quiz_id))
  }

  scope :favorite_rank, -> {
    find(Favorite.where(['created_at LIKE ?', "%#{Date.today}%"]).group(:quiz_id).order('count(quiz_id) desc').limit(20).pluck(:quiz_id))
  }

  require "date"

  def save_tags(tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      article_category = Tag.find_or_create_by(name: new_name)
      self.tags << article_category
    end
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def create_notification_like!(current_user)
    temp = Notification.where([
      "visitor_id = ? and visited_id = ? and quiz_id = ? and action = ? ",
      current_user.id, user_id, id, 'like',
    ])
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

  def create_impression(current_user)
    data = Impression.where([
      "user_id = ? and quiz_id = ? and created_at LIKE ?",
      current_user.id, id, "%#{Date.today}%",
    ])
    if data.blank?
      impression = current_user.impressions.new(quiz_id: id)

      impression.save if impression.valid?
    end
  end
end
