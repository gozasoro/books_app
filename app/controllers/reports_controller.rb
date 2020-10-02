# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_report, only: %i[show edit update destroy]
  before_action :ensure_correct_user, only: %i[edit update destroy]

  # GET /reports
  def index
    @reports = Report.order(created_at: "DESC").page(params[:page])
  end

  def show; end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit; end

  # POST /reports
  def create
    @report = Report.new(report_params)
    @report.user_id = current_user.id

    if @report.save
      redirect_to @report, notice: t("flash.reports.created")
    else
      render :new
    end
  end

  # PATCH/PUT /reports/1
  def update
    if @report.update(report_params)
      redirect_to @report, notice: t("flash.reports.updated")
    else
      render :edit
    end
  end

  # DELETE /reports/1
  def destroy
    @report.destroy
    redirect_to reports_url, notice: t("flash.reports.destroyed")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def report_params
      params.require(:report).permit(:title, :body, :date)
    end

    def ensure_correct_user
      unless @report.user_id == current_user.id
        redirect_to @report, notice: t("flash.reports.not_authorized")
      end
    end
end
