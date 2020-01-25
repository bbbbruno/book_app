# frozen_string_literal: true

class Users::BooksController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @books = @user.books.recent.page(params[:page])
  end
end
