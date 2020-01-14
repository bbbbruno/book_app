# frozen_string_literal: true

class AddIndexAndForeignKeyToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_index :profiles, :user_id, unique: true
    add_foreign_key :profiles, :users
  end
end
