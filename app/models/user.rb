# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :postal_code, format: { with: /\A(\d{3}[-]\d{4})?\z/, message: "半角数字7桁（ハイフンあり）で入力してください" }
end
