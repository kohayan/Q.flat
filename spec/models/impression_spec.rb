require 'rails_helper'

RSpec.describe Impression, type: :model do
  let(:user) { create(:user) }
  let(:quiz) { create(:quiz, user_id: user.id) }

  context "impressionが正しく保存される" do
    before do
      @impression = user.impressions.new(quiz_id: quiz.id)
      @impression.save
    end

    it "正しく保存される" do
      expect(@impression).to be_valid
    end
  end

  context "impressionが正しく保存されない" do
    before do
      @impression = user.impressions.new(quiz_id: "")
      @impression.save
    end

    it "正しく保存されない" do
      expect(@impression).to be_invalid
    end
  end
end
