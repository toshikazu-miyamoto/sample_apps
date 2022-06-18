require "test_helper"

class NoticeTest < ActiveSupport::TestCase
  def setup
    @followed_user = users(:followed_user)
    @follower_user1 = users(:follower_user1)
    @follower_user2 = users(:follower_user2)
  end

  test "フォローされた時通知が１件できる" do
    assert Notice.get_follower_notice!(@followed_user, @follower_user1)
    assert_equal Notice.where(user: @followed_user).count, 1
  end

  test "フォローが続けて２回された時通知が親1件、子供1件ができる" do
    assert Notice.get_follower_notice!(@followed_user, @follower_user1)
    notice = Notice.last
    assert_equal Notice.where(user: @followed_user).where(notice_id: nil).count, 1
    assert_equal notice.optional, {"follow_user_id" => @follower_user1.id}
    assert_equal notice.follower_name, @follower_user1.name
    assert Notice.get_follower_notice!(@followed_user, @follower_user2)
    assert_equal Notice.where(user: @followed_user).where(notice_id: notice.id).count, 1
    notice = Notice.last
    assert_equal notice.optional, {"follow_user_id" => @follower_user2.id}
    assert_equal notice.follower_name, @follower_user2.name
  end


end
