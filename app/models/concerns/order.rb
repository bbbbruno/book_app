# frozen_string_literal: true

module Order
  extend ActiveSupport::Concern

  included do
    scope :recent, -> { order(created_at: :desc) }
    scope :former, -> { order(created_at: :asc) }
  end
end
