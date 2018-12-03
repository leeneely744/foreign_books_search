require "rails_helper"

RSpec.feature "Search and Show", type: :feature do
  fixtures :all
  
  before do
    @firstBook = books(:one)
  end
  
  it "can click return button" do
    visit book_path(@firstBook.id)
    click_on '検索画面へ戻る'
  end
  
end