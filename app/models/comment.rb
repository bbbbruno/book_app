# frozen_string_literal: true

class Comment < ApplicationRecord
  include Order

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :content, presence: true
end
