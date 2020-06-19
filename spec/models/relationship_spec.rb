require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }

  	context "フォローが正しく保存される" do
        before do
            @relationship = Relationship.new(follower_id: user.id, followed_id: other_user.id)
            @relationship.save
        end
        it "正しく保存される" do
            expect(@relationship).to be_valid
        end
    end

    context "フォローが正しく保存されない" do
        before do
            @relationship = Relationship.new(follower_id: "", followed_id: "")
            @relationship.save
        end
        it "正しく保存されない" do
            expect(@relationship).to be_invalid
        end
    end

    context "フォローが正しく削除される" do
        before do
            @relationship = Relationship.new(follower_id: user.id, followed_id: other_user.id)
            @relationship.save
            @relationship.destroy
        end
        it "正しく削除される" do
            expect(@relationship).to be_valid
        end
    end
end
