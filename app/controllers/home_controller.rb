# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @user = current_user
    @books = Book.where(
      'user_id IN (?) or user_id = ?',
      current_user.following_ids,
      current_user.id
    ).order(created_at: :desc).page(params[:page])
  end
end
