# frozen_string_literal: true

class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.string :title, null: false, default: "無題"
      t.text :body, null: false
      t.date :date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
