# frozen_string_literal: true

module ApplicationHelper
  def user_avatar(user:, size: :sm)
    user.resized_avatar(size)
  end
end
