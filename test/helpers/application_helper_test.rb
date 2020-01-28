# frozen_string_literal: true

require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  setup do
    @user = users(:one)
  end

  test 'should return resized avatar' do
    @user.create_profile
    assert_instance_of ActiveStorage::Variant, user_avatar(user: @user, size: :sm)
  end
end
