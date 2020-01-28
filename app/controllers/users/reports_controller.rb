# frozen_string_literal: true

class Users::ReportsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @reports = @user.reports.recent.page(params[:page])
  end
end
