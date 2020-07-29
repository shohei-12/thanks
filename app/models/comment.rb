class Comment < ApplicationRecord
  # User model
  belongs_to :user

  # Post model
  belongs_to :post

  # validations
  validates :content, presence: true, length: { maximum: 400 }
end
