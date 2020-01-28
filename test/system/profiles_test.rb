# frozen_string_literal: true

require 'application_system_test_case'

class ProfilesTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @user.create_profile.update!(id: @user.id)
    login_as @user
  end

  test 'show profile' do
    visit profile_path(id: @user.id)

    assert_selector 'h1', text: I18n.t('profiles.show.title')
  end

  test 'update profile' do
    visit edit_profile_path(id: @user.id)

    fill_in 'profile_name', with: '曹操'
    fill_in 'profile_zipcode', with: '000-0000'
    fill_in 'profile_address', with: '魏'
    fill_in 'profile_self_introduction', with: '天下の大将軍'
    find('input[type="submit"').click

    assert_text I18n.t('flash.update')
  end
end
