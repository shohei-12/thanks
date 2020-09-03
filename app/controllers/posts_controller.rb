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
    @posts = Post.where(status: 1).page(params[:page]).per(20).order(created_at: :desc)
  end

  def popular
    posts_sorted = Post.where(status: 1).order(created_at: :desc).sort { |a, b| b.likes.count <=> a.likes.count }
    @posts = Kaminari.paginate_array(posts_sorted).page(params[:page]).per(20)
  end

  def search
    @search_params = params[:search]
    @posts = Post.search(@search_params).page(params[:page]).per(20).order(created_at: :desc)
  end

  def category
    @category = Category.find(params[:id])
    @posts = @category.posts.where(status: 1).page(params[:page]).per(20).order(created_at: :desc)
  end

  def show
    respond_to do |format|
      format.html do
        if current_user.posts.pluck(:id).include?(params[:id].to_i)
          @post = Post.find(params[:id])
          @comment = Comment.new
          @comments = @post.comments.page(params[:page]).per(20).order(created_at: :desc)
        elsif Post.public_posts.include?(params[:id].to_i)
          @post = Post.find(params[:id])
          @comment = Comment.new
          @comments = @post.comments.page(params[:page]).per(20).order(created_at: :desc)
        else
          redirect_to root_path
        end
      end
      format.js do
        post = Post.find(params[:id])
        @comments = post.comments.page(params[:page]).per(20).order(created_at: :desc)
      end
    end
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
      :content,
      :category_id,
      :check,
      :status
    )
  end

  # before action

  # Check contributor is self
  def check_contributor
    @post = Post.find(params[:id])
    redirect_to root_path unless current_user?(@post.user)
  end
end
