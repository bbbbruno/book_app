# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :set_profile, except: :index
  before_action :authenticate_profile, only: %i[edit update]

  def index
    @profiles = Profile.recent
  end

  def show
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

    def profile_params
      params.require(:profile).permit(:name, :zipcode, :address, :self_introduction)
    end

    def authenticate_profile
      redirect_to @profile, alert: '他のユーザーのプロフィールは編集できません。' unless @profile.user.id == current_user.id
    end
end
