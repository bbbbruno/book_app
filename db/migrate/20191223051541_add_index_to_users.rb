# frozen_string_literal: true

class AddIndexToUsers < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :created_at, order: { created_at: :desc }
  end
end
