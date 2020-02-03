# frozen_string_literal: true

require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @user.create_profile
    login_as @user
  end

  test "create comment for book" do
    book = books(:one)
    visit book_path(id: book.id)

    fill_in "comment_content", with: "良い本だね"
    find('#comment_form input[type="submit"]').click

    assert_text "良い本だね"
  end

  test "create comment for report" do
    report = reports(:one)
    visit report_path(id: report.id)

    within "#comment_form" do
      fill_in "comment_content", with: "お元気ですか？"
      find('input[type="submit"]').click
    end

    assert_text "お元気ですか？"
  end

  test "update comment for book" do
    book = books(:one)
    comment = comments(:one)
    visit book_path(id: book.id)

    within '#comment[data-comment="' + comment.id.to_s + '"]' do
      click_on I18n.t("dictionary.button.edit"), match: :first
      fill_in "comment_content", with: "やっぱり酷い本だ"
      find('input[type="submit"]').click
    end

    assert_text "やっぱり酷い本だ"
  end

  test "destroy comment for book" do
    book = books(:one)
    comment = comments(:one)
    visit book_path(id: book.id)

    within '#comment[data-comment="' + comment.id.to_s + '"]' do
      page.accept_confirm do
        click_on I18n.t("dictionary.button.destroy"), match: :first
      end
    end

    assert_no_text comment.content
  end
end
