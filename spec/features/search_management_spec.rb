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

  feature 'Search form test' do
    before do
      visit search_path
      fill_in 'タイトル', with: 'First'
      select 'first genre', from: 'q[books_genre_id_eq]'
      fill_in '最小ページ数', with: 0
      fill_in '最大ページ数', with: 10
      click_button '検索'
    end

    scenario 'searched First Title' do
      expect(page).to have_content("First Title")
    end

    scenario 'not searched Second Title' do
      expect(page).not_to have_content("Second Title")
    end
  end
end