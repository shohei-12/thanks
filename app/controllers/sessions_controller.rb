class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user&.authenticate(params[:session][:password])
      log_in @user
      remember @user if params[:session][:remember_me] == '1'
      flash[:success] = 'ログインしました！'
      redirect_to @user
    else
      flash.now[:danger] = '入力されたメールアドレスまたはパスワードに誤りがあります'
      render 'new'
    end
  end

  def guest
    @user = User.find_by(email: 'guest@gmail.com')
    log_in @user
    flash[:success] = 'ログインしました！'
    redirect_to @user
  end

  def destroy
    log_out if logged_in?
  end
end
