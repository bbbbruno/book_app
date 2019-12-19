# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :avatar
  before_create { self.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default_avatar.png')), filename: 'dafault_avatar.png', content_type: 'image/png') }

  validates :user_id, uniqueness: true
  validates :zipcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, allow_blank: true }, on: :update

  def profile_avatar(size)
    resize =
      case size
      when :sm
        [50, 50]
      when :md
        [70, 70]
      when :lg
        [200, 200]
      end
    self.avatar.variant(resize_to_fill: resize)
  end
end
