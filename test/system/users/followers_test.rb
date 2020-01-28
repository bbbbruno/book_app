# frozen_string_literal: true

require 'application_system_test_case'

class Users::FollowersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    User.all.each do |user|
      user.create_profile
    end
    login_as @user
  end

  test 'show listing user folllowers' do
    visit user_followers_path(user_id: @user.id)

    assert_text I18n.t('users.followers.index.title', user: @user.username)
  end
end
