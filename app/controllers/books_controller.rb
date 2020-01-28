# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: :show
  before_action :set_my_book, only: %i[edit update destroy]

  def index
    @books =
      Book
        .includes(:picture_attachment, user: { profile: { avatar_attachment: :blob } })
        .where(user: current_user.followings)
        .or(
          Book
            .includes(:picture_attachment, user: { profile: { avatar_attachment: :blob } })
            .where(user: current_user)
        )
        .recent
        .page(params[:page])
  end

  def show
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user

    if @book.save
      redirect_to book_url(@book), notice: t('flash.new')
    else
      render :new
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: t('flash.update')
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to user_books_url(current_user), notice: t('flash.destroy')
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def set_my_book
      @book = current_user.books.find_by(id: params[:id])
      redirect_to user_books_url(current_user), alert: t('dictionary.alert.authenticate') unless @book
    end

    def book_params
      params.require(:book).permit(:title, :memo, :author, :picture)
    end
end
