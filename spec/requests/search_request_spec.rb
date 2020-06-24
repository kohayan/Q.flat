require 'rails_helper'

RSpec.describe "Searches", type: :request do
  describe '検索結果ページ' do
    context "検索結果ページが正しく表示される" do
      before do
        get search_path, params: { keyword: "テスト１　テスト２" }
      end

      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
  end
end
