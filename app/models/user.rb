# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :profile, dependent: :destroy
  after_create { self.create_profile! }

  validates :username, presence: true, uniqueness: true, length: { maximum: 10 }, format: { with: /\A[\w@-]*[A-Za-z][\w@-]*\z/, message: 'に使える文字は半角英数字と@-のみです。必ず英字を１文字以上入力してください。' }
end
