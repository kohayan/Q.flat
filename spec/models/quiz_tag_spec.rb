require 'rails_helper'

RSpec.describe QuizTag, type: :model do
	let(:user) { create(:user) }
	let(:quiz) { create(:quiz, user_id: user.id) }
	before do
        @tag = Tag.new(name: "test_tag")
        @tag.save
    end

	context "QuizTagが正しく保存される" do
        before do
            @quiz_tag = quiz.quiz_tags.new(tag_id: @tag.id)
            @quiz_tag.save
        end
        it "正しく保存される" do
            expect(@quiz_tag).to be_valid
        end
    end

    context "QuizTagが正しく保存されない" do
        before do
            @quiz_tag = quiz.quiz_tags.new(tag_id: "")
            @quiz_tag.save
        end
        it "正しく保存されない" do
            expect(@quiz_tag).to be_invalid
        end
    end

    context "QuizTagが正しく削除される" do
        before do
            @quiz_tag = quiz.quiz_tags.new(tag_id: @tag.id)
            @quiz_tag.save
            @quiz_tag.destroy
        end
        it "正しく削除される" do
            expect(@quiz_tag).to be_valid
        end
    end
end
