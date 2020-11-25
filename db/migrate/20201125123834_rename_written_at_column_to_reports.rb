# frozen_string_literal: true

class RenameWrittenAtColumnToReports < ActiveRecord::Migration[6.0]
  def change
    rename_column :reports, :written_at, :published_on
  end
end
