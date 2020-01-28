# frozen_string_literal: true

class Report < ApplicationRecord
  include Order

  belongs_to :user
  has_many :comments, as: :commentable

  validates :title, presence: true
end
