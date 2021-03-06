# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show edit update]
  before_action :authenticate_profile, only: %i[edit update]

  def show
    @user = @profile.user
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to @profile, notice: t('flash.update')
    else
      render :edit
    end
  end

  private
    def set_profile
      @profile = User.find(params[:id]).profile
    end

    def authenticate_profile
      redirect_to @profile, alert: t('dictionary.alert.authenticate') unless @profile.user == current_user
    end

    def profile_params
      params.require(:profile).permit(:name, :zipcode, :address, :self_introduction, :avatar)
    end
end
