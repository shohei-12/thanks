class User < ApplicationRecord
  attr_accessor :remember_token

  # Post model
  has_many :posts, dependent: :destroy

  # Relationship model
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships,
           class_name: 'Relationship',
           foreign_key: 'follow_id',
           dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user

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

  # Return a random token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Return a hash value of the passed string
  def self.digest(string)
    cost =
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end

  # Set a remember token's hash value for remember_digest
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the token given matches the digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Set remember_digest to nil
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Follow a user
  def follow(user)
    relationships.create(follow_id: user.id) unless self == user
  end

  # Unfollow a user
  def unfollow(user)
    relationship = relationships.find_by(follow_id: user.id)
    relationship&.destroy
  end

  # Return a true if follow a given user
  def following?(user)
    followings.include?(user)
  end
end
