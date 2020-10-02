# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def follows
    @user = User.find(params[:id])
    @users = @user.followings.page(params[:page])
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page])
  end
end
