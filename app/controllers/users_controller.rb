class UsersController < ApplicationController
  before_action :check_login, only: %i[show edit update]
  before_action :check_user, only: %i[edit update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @my_posts = if current_user?(@user)
                  @user.posts.page(params[:page]).per(20).order(created_at: :desc)
                else
                  @user.posts.where(status: 1).page(params[:page]).per(20).order(created_at: :desc)
                end
    @like_posts = if current_user?(@user)
                    @user.like_posts.page(params[:page]).per(20).order(created_at: :desc)
                  else
                    @user.like_posts.where(status: 1).page(params[:page]).per(20).order(created_at: :desc)
                  end
    @followings = @user.followings.page(params[:page]).per(20).order(created_at: :desc)
    @followers = @user.followers.page(params[:page]).per(20).order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.page(params[:page]).per(20).order(created_at: :desc)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :image,
      :image_cache
    )
  end

  # before action

  # Check user is self
  def check_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end
end
