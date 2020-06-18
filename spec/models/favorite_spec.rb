require 'rails_helper'

RSpec.describe Favorite, type: :model do
	let(:user) { create(:user) }
	let(:quiz) { create(:quiz, user_id: user.id) }

	context "お気に入りが正しく保存される" do
        before do
            @favorite = quiz.favorites.new(user_id: user.id)
			@favorite.save
        end
        it "保存される" do
            expect(@favorite).to be_valid
        end
    end

    context "お気に入りが正しく保存されない" do
        before do
            @favorite = Favorite.new(user_id: "", quiz_id: "")
			@favorite.save
        end
        it "保存されない" do
            expect(@favorite).to be_invalid
        end
    end
end
