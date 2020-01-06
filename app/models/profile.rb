# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user

  validates :user_id, uniqueness: true
  validates :zipcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }, on: :update
end
