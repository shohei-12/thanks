class Relationship < ApplicationRecord
  # User model
  belongs_to :user
  belongs_to :follow, class_name: 'User'
end
