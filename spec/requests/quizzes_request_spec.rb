require 'rails_helper'

RSpec.describe "Quizzes", type: :request do
    let(:user) { create(:user) }
    let(:other_user) { create(:other_user) }
    let(:quiz) { create(:quiz, user_id: user.id) }
    let(:quiz_params) { attributes_for(:quiz, tag_list: "テスト1,テスト2") }
    let(:invalid_quiz_params) { attributes_for(:quiz, question: "", tag_list: "") }

    describe 'POST #create' do
        before do
            sign_in user
        end
        context 'パラメータが妥当な場合' do
            it 'リクエストが成功すること' do
                post quizzes_path, params: { quiz: quiz_params }
                expect(response.status).to eq 302
            end

            it 'createが成功すること' do
                expect do
                    post quizzes_path, params: { quiz: quiz_params }
                end
            end

            it 'リダイレクトされること' do
                post quizzes_path, params: { quiz: quiz_params }
                expect(response).to redirect_to home_users_path
            end
        end

        context 'パラメータが不正な場合' do
            it 'リクエストが成功すること' do
                post quizzes_path, params: { quiz: invalid_quiz_params }
                expect(response.status).to eq 200
            end

            it 'createが失敗すること' do
                expect do
                    post quizzes_path, params: { quiz: invalid_quiz_params }
                end
            end
        end
    end

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

        context 'クイズを作成したユーザーじゃない場合' do
            before do
                sign_in other_user
            end
            it 'リダイレクトされること' do
                is_expected.to redirect_to root_path
            end
        end

        context 'ゲストの場合' do
            it 'リダイレクトされること' do
                is_expected.to redirect_to new_user_session_path
            end
        end
    end

    describe 'PATCH #update' do
        subject { patch quiz_path(quiz), params: { quiz: quiz_params, question: "update" } }
        context 'パラメータが妥当な場合' do
            before do
                sign_in user
            end
            it 'リクエストが成功すること' do
                is_expected.to eq 302
            end

            it 'updateが成功すること' do
                is_expected
            end

            it 'リダイレクトされること' do
                is_expected.to redirect_to quiz_path(quiz)
            end
        end

        context 'パラメータが不正な場合' do
            before do
                sign_in user
            end
            it 'リクエストが成功すること' do
                patch quiz_path(quiz), params: { quiz: invalid_quiz_params }
                expect(response.status).to eq 200
            end

            it 'updateが失敗すること' do
                expect do
                    patch quiz_path(quiz), params: { quiz: invalid_quiz_params }
                end
            end
        end

        context 'クイズを作成したユーザーじゃない場合' do
            before do
                sign_in other_user
            end
            it 'リダイレクトされること' do
                patch quiz_path(quiz), params: { quiz: quiz_params, question: "update" }
                is_expected.to redirect_to root_path
            end
        end
    end

    describe 'DELETE #destroy' do
        subject { delete quiz_path(quiz), params: { ref: quizzes_path } }
        context 'パラメータが妥当な場合' do
            before do
                sign_in user
            end
            it 'リクエストが成功すること' do
                is_expected.to eq 302
            end

            it 'destroyが成功すること' do
                is_expected
            end

            it 'リダイレクトされること' do
                is_expected.to redirect_to quizzes_path
            end
        end

        context 'クイズを作成したユーザーじゃない場合' do
            before do
                sign_in other_user
            end
            it 'リダイレクトされること' do
                is_expected.to redirect_to root_path
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
