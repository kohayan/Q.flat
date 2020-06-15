require 'rails_helper'

RSpec.describe Quiz, type: :model do
	let(:user) { create(:user) }
    let(:quiz) { create(:quiz, user_id: user.id) }
    let(:quiz_params) { attributes_for(:quiz) }
    let(:invalid_quiz_params) { attributes_for(:quiz, question: "") }

  	context "データが正しく保存される" do
        before do
            @quiz = user.quizzes.new(quiz_params)
            @quiz.save
        end
        it "全て入力してあるので保存される" do
            expect(@quiz).to be_valid
        end
    end
end
