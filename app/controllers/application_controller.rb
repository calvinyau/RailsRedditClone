class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :require_login!

  def current_user
    @current_user = User.find_by_session_token(session[:session_token])
    @current_user
  end

  def logged_in?
    !!current_user
  end

  def login_user!(user)
    session[:session_token] = user.reset_token!
  end

  def logout!
    session[:session_token] = nil
  end

  def require_login!
    unless logged_in?
      flash[:errors] = ["Login is required to do that action."]
      redirect_to new_sessions_url
    end
  end
end
