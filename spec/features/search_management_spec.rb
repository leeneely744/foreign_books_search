require "rails_helper"

RSpec.feature "Search management", type: :feature do
  fixtures :all
  
  before do
    @firstBook = books(:one)
  end

  scenario "Click a random button" do
    visit search_path
    click_button "ランダム検索"
    expect(current_path).to match("/books/")
  end

  scenario "Return to home" do
    visit book_path(@firstBook.id)
    click_link '検索画面へ戻る'
    expect(page).to have_title '検索'
  end
end