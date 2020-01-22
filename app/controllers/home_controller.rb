# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @user = current_user
    @books = Book.where(user: current_user.followings)
      .or(Book.where(user: current_user))
      .order(created_at: :desc)
      .page(params[:page])
  end
end
