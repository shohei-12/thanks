module SessionsHelper
  # Log in with the given user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns true if the user is logged in
  def logged_in?
    !session[:user_id].nil?
  end

  # Log out the current user
  def log_out
    session.delete(:user_id)
  end
end
