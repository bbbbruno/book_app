# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.recent
  end

  def followings
    @user  = User.find(params[:id])
    @users = @user.followings.order(created_at: :desc)
    render :followings
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers.order(created_at: :desc)
    render :followers
  end
end
