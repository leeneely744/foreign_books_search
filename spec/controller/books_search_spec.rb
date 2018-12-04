require "rails_helper"

describe BooksController, type: :request do
  fixtures :all
  
  describe 'get #search' do
    it "exists seaech page" do
      get search_path
      expect(response.status).to eq 200
      expect(response.body).to include 'タイトル'
      expect(response.body).to include 'ページ数'
      expect(response.body).to include 'ジャンル'
      expect(response.body).to include 'ランダム検索'
    end
  end
end