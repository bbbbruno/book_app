# frozen_string_literal: true

class Book < ApplicationRecord
  include Order

  belongs_to :user
  has_one_attached :picture

  validates :title, presence: true
end
