class Post < ApplicationRecord
  # User model
  belongs_to :user

  # Category model
  belongs_to :category

  # Comment model
  has_many :comments, dependent: :destroy

  # Like model
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  # validations
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 400 }
  validates :check, presence: true, inclusion: { in: [0, 1] }

  # Get id of public posts
  def self.public_posts
    Post.where(status: 1).pluck(:id)
  end

  # Get 10 popular posts
  def self.popular
    Post.find(
      Like.where(post_id: Post.public_posts).group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id)
    )
  end

  # Get posts containing keyword
  def self.search(keyword)
    Post.where(status: 1).where('title LIKE ? OR content LIKE ?', "%#{keyword}%", "%#{keyword}%")
  end
end
