# frozen_string_literal: true

require 'open-uri'
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: %i[github]

  include Order

  has_one :profile, dependent: :destroy
  after_create { self.create_profile! }

  has_many :books, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :active_follows, class_name: 'Follow',
                                  foreign_key: 'following_id',
                                  dependent: :destroy
  has_many :followings, through: :active_follows, source: :followed
  has_many :passive_follows, class_name: 'Follow',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy
  has_many :followers, through: :passive_follows, source: :following

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

  def set_avatar(auth)
    file = open(auth.info.image)
    profile.avatar.attach(io: file, filename: "#{self.username}_avatar.png", content_type: 'image/png')
  end

  def follow!(other_user)
    active_follows.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    active_follows.find_by(followed_id: other_user.id).destroy!
  end

  def following?(other_user)
    followings.include?(other_user)
  end
end
