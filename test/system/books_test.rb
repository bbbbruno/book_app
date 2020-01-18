# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @user.create_profile
    login_as @user
  end

  test 'show listing books' do
    visit books_path
    assert_selector 'h1', text: I18n.t('books.index.title')
  end
end
