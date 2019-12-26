# frozen_string_literal: true

class Report < ApplicationRecord
  include Order

  belongs_to :user
  include Commentable

  validates :title, presence: true
end
