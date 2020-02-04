# frozen_string_literal: true

require "application_system_test_case"

class FollowsTest < ApplicationSystemTestCase
  setup do
    @user1 = users(:one)
    @user2 = users(:two)
    User.all.each do |user|
      user.create_profile
    end
    login_as @user1
  end

  test "create follows relationships" do
    visit profile_path(id: @user2.id)

    click_on I18n.t("profiles.show.follow")
    assert_selector "#unfollow_btn"
  end

  test "destroy follows relationships" do
    @user1.follow!(@user2)
    visit profile_path(id: @user2.id)

    click_on I18n.t("profiles.show.unfollow")
    assert_selector "#follow_btn"
  end
end
