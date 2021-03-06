# frozen_string_literal: true

require "application_system_test_case"

class Users::BooksTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    User.all.each do |user|
      user.create_profile
    end
    login_as @user
  end

  test "show listing user books" do
    visit user_books_path(user_id: @user.id)

    assert_selector "h1", text: I18n.t("users.books.index.title", user: @user.username)
  end
end
