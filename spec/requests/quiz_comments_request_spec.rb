require 'rails_helper'

RSpec.describe "QuizComments", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:quiz) { create(:quiz, user_id: user.id) }

  describe 'POST #create' do
    before do
      sign_in user
    end

    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post quiz_quiz_comments_path(quiz), params: { quiz_comment: { comment: "test-comment" } }, xhr: true
        expect(response.status).to eq 200
      end

      it 'createが成功すること' do
        expect do
          post quiz_quiz_comments_path(quiz), params: { quiz_comment: { comment: "test-comment" } }, xhr: true
        end
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post quiz_quiz_comments_path(quiz), params: { quiz_comment: { comment: "" } }, xhr: true
        expect(response.status).to eq 200
      end

      it 'createが失敗すること' do
        expect do
          post quiz_quiz_comments_path(quiz), params: { quiz_comment: { comment: "" } }, xhr: true
        end
      end
    end
  end
end
