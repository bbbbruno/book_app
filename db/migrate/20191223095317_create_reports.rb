# frozen_string_literal: true

class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.string :title
      t.date :date
      t.text :content
      t.references :user, index: true, foreign_key: true

      t.timestamps

      t.index :created_at, order: :desc
    end
  end
end
