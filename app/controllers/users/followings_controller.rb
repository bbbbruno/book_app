# frozen_string_literal: true

class Users::FollowingsController < ApplicationController
  def index
    @user  = User.find(params[:user_id])
    @users =
      @user
        .followings
        .includes(profile: { avatar_attachment: :blob })
        .recent
        .page(params[:page])
  end
end
