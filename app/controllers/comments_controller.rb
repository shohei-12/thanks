class CommentsController < ApplicationController
  before_action :check_login

  def create
    @post = Post.find(params[:comment][:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
  end

  private

  def comment_params
    params.require(:comment).permit(
      :content
    )
  end
end
