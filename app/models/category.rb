class Category < ApplicationRecord
  # Post model
  has_many :posts, dependent: :destroy
end
