class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  # before action

  # Check user is logged in
  def check_login
    redirect_to login_path unless logged_in?
  end
end
