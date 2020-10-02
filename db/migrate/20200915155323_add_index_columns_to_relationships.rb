# frozen_string_literal: true

class AddIndexColumnsToRelationships < ActiveRecord::Migration[6.0]
  def change
    add_index :relationships, :following_id
    add_index :relationships, :follower_id
    add_index :relationships, [:following_id, :follower_id], unique: true
  end
end
