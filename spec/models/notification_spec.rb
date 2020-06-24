require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:quiz) { create(:quiz, user_id: user.id) }

  context "通知が正しく保存される" do
    before do
      @notification = Notification.new(
        visitor_id: user.id,
        visited_id: other_user.id,
        action: "follow"
      )
      @notification.save
    end

    it "正しく保存される" do
      expect(@notification).to be_valid
    end
  end

  context "通知が正しく保存されない" do
    before do
      @notification = Notification.new(
        visitor_id: user,
        visited_id: other_user,
        action: ""
      )
      @notification.save
    end

    it "正しく保存されない" do
      expect(@notification).to be_invalid
    end
  end
end
