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

  feature 'strong_parameter' do
    it 'pass only correct parameters' do
      # 'incorrect_parameter' is incorrect parameter
      incorrectParams = ActionController::Parameters.new({
        q: {
          title_cont: "test",
          page_gteq: "10",
          page_lteq: "20",
          books_genre_id_eq: "005401001",
          incorrect_parameter: "test"
        }
      })
      booksContoroller = BooksController.new
      usedParam = booksContoroller.send :strong_parameter, incorrectParams
      expect(usedParam[:incorrect_parameter]).to eq nil
    end
  end
end