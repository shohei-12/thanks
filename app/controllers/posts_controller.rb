class PostsController < ApplicationController
  before_action :check_login, only: %i[new create show edit update destroy]
  before_action :check_contributor, only: %i[edit update destroy]

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to current_user
    else
      render 'new'
    end
  end

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to user_path(@post.user)
  end

  private

  def post_params
    params.require(:post).permit(
      :title,
      :content
    )
  end

  # before action

  # Check contributor is self
  def check_contributor
    @post = Post.find(params[:id])
    redirect_to root_path unless current_user?(@post.user)
  end
end
