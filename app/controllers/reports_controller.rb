# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: :show
  before_action :set_my_report, only: %i[edit update destroy]

  def index
    @reports =
      Report
        .recent
        .page(params[:page])
  end

  def show
  end

  def new
    @report = Report.new
  end

  def edit
  end

  def create
    @report = Report.new(report_params)
    @report.user = current_user

    if @report.save
      redirect_to @report, notice: t('flash.new')
    else
      render :new
    end
  end

  def update
    if @report.update(report_params)
      redirect_to @report, notice: t('flash.update')
    else
      render :edit
    end
  end

  def destroy
    @report.destroy

    redirect_to user_reports_path(current_user), notice: t('flash.destroy')
  end

  private
    def set_report
      @report = Report.find(params[:id])
    end

    def set_my_report
      @report = current_user.reports.find_by(id: params[:id])
      redirect_to user_reports_url(current_user), alert: t('dictionary.alert.authenticate') unless @report
    end

    def report_params
      params.require(:report).permit(:title, :date, :content)
    end
end
