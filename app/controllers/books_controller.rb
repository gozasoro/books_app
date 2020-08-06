# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_locale
  before_action :set_book, only: %i[show edit update destroy]

  PER = 20

  # GET /books
  def index
    @books = Book.page(params[:page]).per(PER)
  end

  # GET /books/1
  def show; end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit; end

  # POST /books
  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: t("flash.created")
    else
      render :new
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      redirect_to @book, notice: t("flash.updated")
    else
      render :edit
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
    redirect_to books_url, notice: t("flash.destroyed")
  end

  private
    def set_locale
      I18n.locale = locale_in_params || I18n.default_locale
    end

    def locale_in_params
      if params[:locale].present?
        params[:locale].to_sym.presence_in(I18n.available_locales)
      else
        nil
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :memo, :author, :picture)
    end

    def default_url_options
      { locale: I18n.locale }
    end
end
