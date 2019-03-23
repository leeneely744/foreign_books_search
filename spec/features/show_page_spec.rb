require 'rails_helper'

feature 'show page' do
  fixtures :all

  background do
    @firstBook = books(:one)
    @secondBook = books(:two)
  end

  it "move to search page when click a return button" do
    visit book_path(@firstBook.id)
    click_button '検索画面へ戻る'
    expect(page).to have_title '検索'
  end

  context 'if exists item_url' do
    it 'show rakuten-button' do
      visit book_path(@firstBook.id)
      expect(page).to have_button '楽天で見る'
    end
  end

  context 'if not exists item_url' do
    it 'not show rakuten-button' do
      visit book_path(@secondBook.id)
      expect(page).not_to have_button '楽天で見る'
    end
  end
end