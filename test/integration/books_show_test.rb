require 'test_helper'

class BooksSearchTest < ActionDispatch::IntegrationTest
  
  def setup
    @firstBook = books(:one)
  end
  
  test "title has book name" do
    get book_path(@firstBook.id)
    assert_response :success
    assert_select 'title', full_title(@firstBook.title)
  end
  
  test "should exists return button in show page" do
    get book_path(@firstBook.id)
    assert_response :success
    
    # 戻るボタンが存在し、hrefがsearch_pageである
    assert_select "a[href=?]", search_path
  end
end
