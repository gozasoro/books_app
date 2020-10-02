# frozen_string_literal: true

class ChangeColumnsAddNotnullOnRelationships < ActiveRecord::Migration[6.0]
  def change
    change_column :relationships, :following_id, :integer, null: false
    change_column :relationships, :follower_id, :integer, null: false
  end
end
