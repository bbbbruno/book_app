# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_user
  before_action :authenticate_user, only: %i[new create edit update destroy]
  before_action :set_report, only: %i[show edit update destroy]

  def index
    @reports = @user.reports.order(created_at: :desc).page(params[:page])
  end

  def show
  end

  def new
    @report = @user.reports.build
  end

  def edit
  end

  def create
    @report = @user.reports.build(report_params)

    if @report.save
      redirect_to user_report_url(@user, @report), notice: t('flash.new')
    else
      render :new
    end
  end

  def update
    if @report.update(report_params)
      redirect_to user_report_url(@user, @report), notice: t('flash.update')
    else
      render :edit
    end
  end

  def destroy
    @report.destroy

    redirect_to user_reports_path, notice: t('flash.destroy')
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    def set_report
      @report = @user.reports.find(params[:id])
    end

    def authenticate_user
      redirect_to user_reports_url(@user), alert: t('controller.alert.authenticate') unless current_user == @user
    end

    def report_params
      params.require(:report).permit(:title, :date, :content)
    end
end
