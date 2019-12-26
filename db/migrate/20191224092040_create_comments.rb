# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.references :user, foreign_key: true, null: false
      t.references :commentable, polymorphic: true, null: false

      t.timestamps

      t.index :created_at, order: :asc
    end
  end
end
