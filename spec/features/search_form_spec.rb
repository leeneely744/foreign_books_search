require "rails_helper"

feature "search form test" do
  fixtures :all

  before do
    @firstBook = books(:one)
    visit search_path
    fill_in 'タイトル', with: 'First'
    fill_in '最小ページ数', with: 10
    fill_in '最大ページ数', with: 19
    select 'first genre', from: 'q[books_genre_id_eq]'
  end

  feature 'memory search condition' do
    it 'should be filled in previous search condition' do
      click_button '検索'
      visit book_path(@firstBook.id)
      click_link '検索画面へ戻る'
      expect(page).to have_field 'タイトル', with: 'First'
      expect(page).to have_field '最小ページ数', with: 10
      expect(page).to have_field '最大ページ数', with: 19
      expect(page).to have_select 'q[books_genre_id_eq]', selected: 'first genre'
    end
  end
end