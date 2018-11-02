require 'test_helper'

class BooksSearchTest < ActionDispatch::IntegrationTest
  test "should search books by title" do
    get search_path
    assert_select "input[id=?]", "title"
    get search_path, params: { title: "test title" }
    assert_template 'books/search'
  end
end
