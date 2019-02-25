require "rails_helper"

feature "Search management" do
  fixtures :all
  
  background do
    @firstBook = books(:one)
  end

  scenario "Click a random button" do
    visit search_path
    click_button "ランダム検索"
    expect(current_path).to match("/books/")
  end

  scenario "Return to search page from show page" do
    visit book_path(@firstBook.id)
    click_link '検索画面へ戻る'
    expect(page).to have_title '検索'
  end
end