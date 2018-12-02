require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
    test "full title helper" do
        # 引数がなかったとき
        assert_equal full_title, 'Ruby on Rails Tutorial Sample App'
        # 引数があったとき
        assert_equal full_title("test"), 'test | Ruby on Rails Tutorial Sample App'
    end
end