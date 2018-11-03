require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  test "should get search" do
    get search_path
    assert_response :success
    
    assert_select "input[id=?]", "q_title_cont"
  end
end
