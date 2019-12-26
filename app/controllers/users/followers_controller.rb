# frozen_string_literal: true

class Users::FollowersController < ApplicationController
  def index
    @user  = User.find(params[:user_id])
    @users = @user.followers.recent.page(params[:page])
  end
end
