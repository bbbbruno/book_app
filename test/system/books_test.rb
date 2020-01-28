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

  test 'create book' do
    visit new_book_path

    fill_in 'book_title', with: 'プーさんの冒険'
    fill_in 'book_memo', with: 'ワクワクのアドベンチャー'
    fill_in 'book_author', with: 'ドナルド・トランプ'
    attach_file 'book_picture', Rails.root.join('public/uploads/book/picture/4/download.jpg')
    find('input[type="submit"]').click

    assert_text I18n.t('flash.new')
  end

  test 'show book' do
    book = books(:one)
    visit book_path(id: book.id)

    assert_selector 'h1', text: I18n.t('books.show.title')
  end

  test 'update book' do
    book = books(:one)
    visit edit_book_path(id: book.id)

    fill_in 'book_title', with: '鏡の中のマリオネット'
    fill_in 'book_memo', with: '最高の歌'
    fill_in 'book_author', with: '金正恩'
    find('input[type="submit"]').click

    assert_text I18n.t('flash.update')
  end

  test 'destroy book' do
    visit books_path
    page.accept_confirm do
      click_on I18n.t('dictionary.button.destroy'), match: :first
    end

    assert_text I18n.t('flash.destroy')
  end
end
