# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_user
  before_action :set_book, only: %i[show edit update destroy]
  before_action :authenticate_user, only: %i[new create edit update destroy]

  def index
    @books = @user.books.order(created_at: :desc).page(params[:page])
  end

  def show; end

  def new
    @book = @user.books.build
  end

  def edit; end

  def create
    @book = @user.books.build(book_params)

    if @book.save
      redirect_to user_book_url(@user, @book), notice: t('flash.new')
    else
      render :new
    end
  end

  def update
    if @book.update(book_params)
      redirect_to user_book_url(@user, @book), notice: t('flash.update')
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to user_books_url(@user), notice: t('flash.destroy')
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    def set_book
      @book = @user.books.find(params[:id])
    end

    def authenticate_user
      redirect_to user_books_url(@user), alert: t('books.alert.authenticate') unless current_user == @user
    end

    def book_params
      params.require(:book).permit(:title, :memo, :author, :picture)
    end
end
