# frozen_string_literal: true

class AddIndexToBooks < ActiveRecord::Migration[6.0]
  def change
    add_index :books, :created_at, order: { created_at: :desc }
  end
end
