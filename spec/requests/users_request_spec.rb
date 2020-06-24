require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_user_params) { attributes_for(:user, nick_name: "") }

  describe 'POST #create' do
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: user_params }
        expect(response.status).to eq 302
      end

      it 'createが成功すること' do
        expect do
          post user_registration_path, params: { user: user_params }
        end
      end

      it 'リダイレクトされること' do
        post user_registration_path, params: { user: user_params }
        expect(response).to redirect_to home_users_path
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.status).to eq 200
      end

      it 'createが失敗すること' do
        expect do
          post user_registration_path, params: { user: invalid_user_params }
        end
      end

      it 'エラーが表示されること' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.body).to include '入力してください'
      end
    end
  end

  describe 'GET #home' do
    subject { get home_users_path }

    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it 'リクエストが成功すること' do
        is_expected.to eq 200
      end
    end

    context 'ゲストの場合' do
      it 'リダイレクトされること' do
        is_expected.to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #edit' do
    subject { get edit_user_path(user) }

    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it 'リクエストが成功すること' do
        is_expected.to eq 200
      end
    end

    context 'ゲストの場合' do
      it 'リダイレクトされること' do
        is_expected.to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #show' do
    subject { get user_path(user) }

    it 'リクエストが成功すること' do
      is_expected.to eq 200
    end

    context 'ユーザーが存在しない場合' do
      it 'リダイレクトされること' do
        user.destroy
        is_expected.to redirect_to quizzes_path
      end
    end
  end
end
