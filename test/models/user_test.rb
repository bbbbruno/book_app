# frozen_string_literal: true

require "test_helper"

# OmniAuthをテストモードに変更
OmniAuth.config.test_mode = true

class UserTest < ActiveSupport::TestCase
  def setup
    @user1 = users(:one)
    @user2 = users(:two)
  end

  test "#find_for_github_oauth should find user when already exists" do
    auth = OmniAuth::AuthHash.new(
      uid: @user1.uid,
      provider: @user1.provider,
      info: { name: @user1.username },
    )
    auth_user = User.find_for_github_oauth(auth)
    assert_equal @user1, auth_user
  end

  test "#find_for_github_oauth should create user when does not exist" do
    auth = OmniAuth::AuthHash.new(
      uid: 56789,
      provider: "github",
      info: { name: "newman" },
    )
    auth_user = User.find_for_github_oauth(auth)
    assert_equal User.last, auth_user
  end

  test "#set_avatar should attach avatar to profile" do
    profile = @user1.create_profile
    auth = OmniAuth::AuthHash.new(info: { image: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png" })
    @user1.set_avatar(auth)
    assert_equal "#{@user1.username}_avatar", profile.avatar.filename.base
  end

  test "#following? should return true if user is following other user" do
    @user1.active_follows.create!(followed_id: @user2.id)
    assert @user1.following?(@user2)
  end

  test "#follow! should follow other user" do
    @user1.follow!(@user2)
    assert @user1.followings.include?(@user2)
  end

  test "#unfollow! should unfollow other user" do
    @user1.active_follows.create!(followed_id: @user2.id)
    @user1.unfollow!(@user2)
    assert_not @user1.followings.include?(@user2)
  end
end
