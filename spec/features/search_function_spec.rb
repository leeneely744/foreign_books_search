require "rails_helper"

feature "search function" do
  fixtures :all
  
  background do
    @firstBook = books(:one)
  end

  it "move to a book show page when click a random button" do
    visit search_path
    click_button "ランダム検索"
    expect(current_path).to match("/books/")
  end

  it "move to search page when click a return button" do
    visit book_path(@firstBook.id)
    click_link '検索画面へ戻る'
    expect(page).to have_title '検索'
  end

  feature 'page num form test' do
    before do
      visit search_path
      fill_in '最小ページ数', with: 10
      fill_in '最大ページ数', with: 19
      click_button '検索'
    end

    it 'should exists books less than 10 pages' do
      expect(page).to have_content("First Title")
    end

    it 'should not exists books more than 20 pages' do
      expect(page).not_to have_content("Second Title")
    end

    it 'should not exists books less than 9 pages' do
      expect(page).not_to have_content("Third Title")
    end
  end

  feature 'genre form test' do
    before do
      visit search_path
      select 'first genre', from: 'q[books_genre_id_eq]'
      click_button '検索'
    end

    it 'should exists books of first genre' do
      expect(page).to have_content("First Title")
    end

    it 'should not exists books of other first genre' do
      expect(page).not_to have_content("Second Title")
    end
  end

  feature 'title form test' do
    before do
      visit search_path
      fill_in 'タイトル', with: 'First'
    end

    it 'should exists First Title' do
      expect(page).to have_content("First Title")
    end

    it 'should not exists Second Title' do
      expect(page).not_to have_content("Second Title")
    end
  end
end