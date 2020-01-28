# frozen_string_literal: true

require 'application_system_test_case'

class FollowsTest < ApplicationSystemTestCase
  setup do
    @user1 = users(:one)
    @user2 = users(:two)
    User.all.each do |user|
      user.create_profile
    end
    login_as @user1
  end

  test 'create follows relationships' do
    visit profile_path(id: @user2.id)

    assert_difference 'Follow.count', 1 do
      click_on I18n.t('profiles.show.follow')
      wait_for_css_appear('#unfollow_btn')
    end
  end

  test 'destroy follows relationships' do
    @user1.follow!(@user2)
    visit profile_path(id: @user2.id)

    assert_difference 'Follow.count', -1 do
      click_on I18n.t('profiles.show.unfollow')
      wait_for_css_appear('#follow_btn')
    end
  end
end
