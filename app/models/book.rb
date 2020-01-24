# frozen_string_literal: true

class Book < ApplicationRecord
  has_one_attached :picture

  belongs_to :user

  validates :title, presence: true
end
