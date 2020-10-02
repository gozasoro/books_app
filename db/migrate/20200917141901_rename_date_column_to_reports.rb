# frozen_string_literal: true

class RenameDateColumnToReports < ActiveRecord::Migration[6.0]
  def change
    rename_column :reports, :date, :written_at
  end
end
