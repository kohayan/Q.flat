require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe 'アバウトページ' do
        context "アバウトページが正しく表示される" do
            before do
                get homes_about_path
            end
            it 'リクエストは200 OKとなること' do
                expect(response.status).to eq 200
            end
        end
    end
end
