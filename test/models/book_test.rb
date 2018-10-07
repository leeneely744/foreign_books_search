require 'test_helper'

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "should must exist check" do
    book = Book.new
    assert_not book.save
  end
end
