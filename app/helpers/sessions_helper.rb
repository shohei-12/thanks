module SessionsHelper
  # Log in with the given user
  def log_in(user)
    session[:user_id] = user.id
  end
end
