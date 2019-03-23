require 'rails_helper'

feature 'show page' do
  fixtures :all

  background do
    @firstBook = books(:one)
  end

  it "move to search page when click a return button" do
    visit book_path(@firstBook.id)
    click_button '検索画面へ戻る'
    expect(page).to have_title '検索'
  end
end