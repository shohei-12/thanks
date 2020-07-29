class Post < ApplicationRecord
  # User model
  belongs_to :user

  # Comment model
  has_many :comments, dependent: :destroy

  # validations
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 400 }
end
