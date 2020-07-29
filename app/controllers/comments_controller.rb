class CommentsController < ApplicationController
  before_action :check_login
  before_action :check_commenter, only: %i[destroy]

  def create
    @post = Post.find(params[:comment][:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
  end

  def destroy
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(
      :content
    )
  end

  # before action

  # Check commenter is self
  def check_commenter
    @comment = Comment.find(params[:id])
    redirect_to root_path unless current_user?(@comment.user)
  end
end
