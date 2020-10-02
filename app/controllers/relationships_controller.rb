# frozen_string_literal: true

class RelationshipsController < ApplicationController
  def create
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    if follow.save
      redirect_to user_path(params[:user_id]), notice: t("flash.relationships.follow.success")
    else
      redirect_to user_path(params[:user_id]), alert: t("flash.relationships.follow.failed")
    end
  end

  def destroy
    follow = current_user.active_relationships.find_by!(follower_id: params[:user_id])
    if follow.destroy
      redirect_to user_path(params[:user_id]), notice: t("flash.relationships.unfollow.success")
    else
      redirect_to user_path(params[:user_id]), alert: t("flash.relationships.unfollow.failed")
    end
  end
end
