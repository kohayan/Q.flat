class Impression < ApplicationRecord
  validates :user, :quiz, presence: true

  belongs_to :user
  belongs_to :quiz
end
