require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_user_params) { attributes_for(:user, nick_name: "") }

  context "クイズが正しく保存される" do
        before do
            @user = User.new(user_params)
            @user.save
        end
        it "全て入力してあるので保存される" do
            expect(@user).to be_valid
        end
    end

    context "クイズが正しく保存されない" do
        before do
            @user = User.new(invalid_user_params)
            @user.save
        end
        it "question,answerが入力されていないので保存されない" do
            expect(@user).to be_invalid
        end
    end

    context "クイズが正しく更新される" do
        before do
            @user = user
            @user.update(nick_name: "update-test", email: "update@test", introduction: "")
        end
        it "正しく更新される" do
            expect(@user).to be_valid
        end
    end
end
