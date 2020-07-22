class User < ApplicationRecord
  # validations
  validates :name, presence: true, length: { maximum: 50 }
  validates :email,
            presence: true,
            uniqueness: true,
            length: { maximum: 256 },
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: 'の形式が正しくありません' }
  validates :password,
            presence: true,
            confirmation: true,
            length: { minimum: 6 },
            format: { with: /\A[\w\-]+\z/, message: 'は英数字、ハイフン、アンダーバーのみ利用可能です' }
  has_secure_password validations: false
end
