require "rails_helper"

describe BooksController, type: :request do
  describe 'get #search' do
    it "exists seaech page" do
      get search_path
      expect(response.status).to eq 200
    end
  end
end