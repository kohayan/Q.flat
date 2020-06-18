require 'rails_helper'

RSpec.describe Quiz, type: :model do
	let(:user) { create(:user) }
    let(:quiz) { create(:quiz, user_id: user.id) }
    let(:quiz_params) { attributes_for(:quiz) }
    let(:invalid_quiz_params) { attributes_for(:quiz, question: "") }

  	context "クイズが正しく保存される" do
        before do
            @quiz = user.quizzes.new(quiz_params)
            @quiz.save
        end
        it "全て入力してあるので保存される" do
            expect(@quiz).to be_valid
        end
    end

    context "クイズが正しく保存されない" do
        before do
            @quiz = Quiz.new(invalid_quiz_params)
            @quiz.save
        end
        it "question,answerが入力されていないので保存されない" do
            expect(@quiz).to be_invalid
        end
    end

    context "クイズが正しく更新される" do
        before do
            @quiz = quiz
            @quiz.update(question: "update-test", answer: "update-test")
        end
        it "正しく更新される" do
            expect(@quiz).to be_valid
        end
    end

    context "クイズが正しく削除される" do
        before do
            @quiz = quiz
            @quiz.destroy
        end
        it "正しく削除される" do
            expect(@quiz).to be_valid
        end
    end
end
