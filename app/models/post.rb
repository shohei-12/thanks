class Post < ApplicationRecord
  # User model
  belongs_to :user

  # Comment model
  has_many :comments, dependent: :destroy

  # Like model
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  # validations
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 400 }
end
