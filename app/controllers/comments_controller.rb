# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, except: :create

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @commentable, notice: t("flash.comments.created")
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to @commentable, notice: t("flash.comments.updated")
    else
      render :edit
    end
  end

  def destroy
    if @comment.destroy
      redirect_to @commentable, notice: t("flash.comments.destroyed")
    end
  end

  private
    def set_commentable
      @commentable = Book.find(params[:book_id]) if params[:book_id]
      @commentable = Report.find(params[:report_id]) if params[:report_id]
    end

    def set_comment
      @comment = current_user.comments.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
