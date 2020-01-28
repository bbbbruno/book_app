# frozen_string_literal: true

require 'test_helper'

class FollowsHelperTest < ActionView::TestCase
  setup do
    @user1 = users(:one)
    @user2 = users(:two)
    @user1.follow!(@user2)
  end

  test 'should return user follwings count' do
    assert_equal 'フォロー数 1', count_followings(@user1)
  end

  test 'should return user followers count' do
    assert_equal 'フォロワー数 1', count_followers(@user2)
  end
end
