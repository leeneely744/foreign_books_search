require "rails_helper"

describe BooksController, type: :request do
  fixtures :all
  
  before do
    @firstBook = books(:one)
  end
  
  describe 'show page test' do
    it "can click return button" do
      get book_path(@firstBook.id)
      expect(response.status).to eq 200
      expect(response.body).to include @firstBook.title
      expect(response.body).to include '検索画面へ戻る'
    end
    
  end
end