# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.recent.page(params[:page])
  end
end
