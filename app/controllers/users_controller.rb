# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users =
      User
        .includes(profile: { avatar_attachment: :blob })
        .recent
        .page(params[:page])
  end
end
