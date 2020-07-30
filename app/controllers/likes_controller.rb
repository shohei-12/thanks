class LikesController < ApplicationController
  before_action :check_login
  before_action :set_post, only: %i[post_create post_destroy]
  before_action :set_comment, only: %i[comment_create comment_destroy]

  def post_create
    @like = current_user.likes.create(post_id: @post.id)
  end

  def post_destroy
    @like = current_user.likes.find_by(post_id: @post.id)
    @like.destroy
  end

  def comment_create
    @like = current_user.likes.create(comment_id: @comment.id)
  end

  def comment_destroy
    @like = current_user.likes.find_by(comment_id: @comment.id)
    @like.destroy
  end

  private

  # before action

  def set_post
    @post = Post.find(params[:id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
