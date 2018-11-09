require 'test_helper'

class BookTest < ActiveSupport::TestCase
  def setup
    @newBook = Book.new
  end
  
  test "should must exist check" do
    assert_not @newBook.save
  end
end
