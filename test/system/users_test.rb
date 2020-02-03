# frozen_string_literal: true

require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    User.all.each do |user|
      user.create_profile
    end
    login_as @user
  end

  test "show listing users" do
    visit users_path

    assert_selector "h1", text: I18n.t("users.index.title")
  end
end
