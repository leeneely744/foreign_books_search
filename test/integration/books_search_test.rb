require 'test_helper'

class BooksSearchTest < ActionDispatch::IntegrationTest
  test "should search books by title" do
    get search_path
    assert_select "input[id=?]", "title"
  end
end
