# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :zipcode
      t.string :address
      t.text :self_introduction
      t.integer :user_id

      t.timestamps
    end
    add_index :profiles, :user_id, unique: true
  end
end
