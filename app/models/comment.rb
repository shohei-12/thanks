class Comment < ApplicationRecord
  # User model
  belongs_to :user

  # Post model
  belongs_to :post

  # Like model
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  # validations
  validates :content, presence: true, length: { maximum: 400 }
end
