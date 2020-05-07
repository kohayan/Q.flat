class Notification < ApplicationRecord
	validates :visitor_id, :visited_id, presence: true
	validates :action,  presence: true
	validates :checked, inclusion: {in: [true,false]}

	belongs_to :visitor, class_name: "User", optional: true
	belongs_to :visited, class_name: "User", optional: true
	belongs_to :quiz, optional: true
	belongs_to :comment, optional: true

	default_scope -> { order(created_at: :desc) }
end
