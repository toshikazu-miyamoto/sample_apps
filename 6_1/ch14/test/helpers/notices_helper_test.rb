require 'test_helper'

class NoticesHelperTest < ActionView::TestCase
  def setup
    @follower = users(:michael)
    @notice_child_exist = notices(:get_follower_notice_parent)
    @notice_no_child = notices(:child1)
    @notice_first_login = notices(:first_login_notice)
  end

  test "通知が複数の人からフォローされた時のメッセージ" do
    assert_equal notice_message(@notice_child_exist), "test4_userさん、他2名にフォローされました。"
  end

  test "通知が一人の人からフォローされた時のメッセージ" do
    assert_equal notice_message(@notice_no_child), "test2_userさんにフォローされました。"
  end

  test "通知が初回ログインした時のメッセージ" do
    assert_equal notice_message(@notice_first_login), "初回ログインありがとうございます。"
  end
end