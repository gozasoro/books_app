# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :avatar
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following
  has_many :reports, dependent: :destroy
  has_many :comments, dependent: :destroy

  def followed_by?(user)
    self.passive_relationships.exists?(following_id: user.id)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[github]
  validates :postal_code, format: { with: /\A(\d{3}[-]\d{4})?\z/, message: "半角数字7桁（ハイフンあり）で入力してください" }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.nickname
      user.email = auth.info.email || User.dummy_email(auth)
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

  def update_with_password(params, *options)
    if provider.present?
      update(params, *options)
    else
      super
    end
  end
end
