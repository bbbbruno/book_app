# frozen_string_literal: true

class Book < ApplicationRecord
  include Order

  belongs_to :user
  has_one_attached :picture
  has_many :comments, as: :commentable

  validates :title, presence: true
end
