require 'rails_helper'

RSpec.describe QuizComment, type: :model do
  let(:user) { create(:user) }
  let(:quiz) { create(:quiz, user_id: user.id) }

  context "コメントが正しく保存される" do
    before do
      @comment = quiz.quiz_comments.new(user_id: user.id, comment: "テスト")
      @comment.save
    end

    it "全て入力してあるので保存される" do
      expect(@comment).to be_valid
    end
  end

  context "コメントが正しく保存されない" do
    before do
      @comment = quiz.quiz_comments.new(user_id: user.id, comment: "")
      @comment.save
    end

    it "commentが入力されていないので保存されない" do
      expect(@comment).to be_invalid
    end
  end

  context "コメントが正しく削除される" do
    before do
      @comment = quiz.quiz_comments.new(user_id: user.id, comment: "テスト")
      @comment.save
      @comment.destroy
    end

    it "正しく削除される" do
      expect(@comment).to be_valid
    end
  end
end
