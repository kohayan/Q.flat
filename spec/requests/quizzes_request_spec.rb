require 'rails_helper'

RSpec.describe "Quizzes", type: :request do
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
