module TestHelper
  # Log in with the given user
  def log_in(user)
    page.set_rack_session(user_id: user.id)
  end
end
