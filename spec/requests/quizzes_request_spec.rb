require 'rails_helper'

RSpec.describe "Quizzes", type: :request do
    let(:user) { create(:user) }
    let(:quiz) { create(:quiz, user_id: user.id) }
    let(:quiz_params) { attributes_for(:quiz) }
    let(:invalid_quiz_params) { attributes_for(:quiz, question: "") }

	describe 'クイズ一覧ページ' do
        context "クイズ一覧ページが正しく表示される" do
            before do
                get quizzes_path
            end
            it 'リクエストは200 OKとなること' do
                expect(response.status).to eq 200
            end
        end
    end

    describe 'GET #show' do
        subject { get quiz_path(quiz) }
        it 'リクエストが成功すること' do
            is_expected.to eq 200
        end

        context 'クイズが存在しない場合' do
            it 'リダイレクトされること' do
                quiz.destroy
                is_expected.to redirect_to quizzes_path
            end
        end
    end

    describe 'GET #edit' do
        subject { get edit_quiz_path(quiz) }
        context 'ログインしている場合' do
            before do
                sign_in user
            end
            it 'リクエストが成功すること' do
                is_expected.to eq 200
            end
            it 'クイズが存在しない場合リダイレクトされること' do
                quiz.destroy
                is_expected.to redirect_to quizzes_path
            end
        end

        context 'ゲストの場合' do
            it 'リダイレクトされること' do
                is_expected.to redirect_to new_user_session_path
            end
        end
    end

    describe '人気クイズページ' do
        context "人気クイズページが正しく表示される" do
            before do
                get famous_quizzes_path
            end
            it 'リクエストは200 OKとなること' do
                expect(response.status).to eq 200
            end
        end
    end
end
