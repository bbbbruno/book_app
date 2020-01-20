# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: %i[github]

  has_one :profile, dependent: :destroy
  after_create { self.create_profile! }

  validates :username, presence: true, uniqueness: true, length: { maximum: 10 }, format: { with: /\A[\w@-]*[A-Za-z][\w@-]*\z/, message: 'に使える文字は半角英数字と@-のみです。必ず英字を１文字以上入力してください。' }

  def self.find_for_github_oauth(auth, signed_in_resource = nil)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.username = auth.info.name
      user.email = User.dummy_email(auth)
      user.password = Devise.friendly_token[0, 20]

      # メール認証をスキップする
      user.skip_confirmation!
    end
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

  def self.create_unique_string
    SecureRandom.uuid
  end
end
