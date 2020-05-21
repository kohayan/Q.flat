class Notification < ApplicationRecord
  validates :visitor_id, :visited_id, presence: true
  validates :action,  presence: true, inclusion: { in: ["like", "follow", "comment"] }
  validates :checked, inclusion: { in: [true, false] }

  belongs_to :visitor, class_name: "User", optional: true
  belongs_to :visited, class_name: "User", optional: true
  belongs_to :quiz, optional: true
  belongs_to :quiz_comment, optional: true

  scope :date, -> { order(created_at: :desc) }
end
