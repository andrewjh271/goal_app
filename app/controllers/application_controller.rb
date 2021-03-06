class ApplicationController < ActionController::Base
  helper_method :current_user

  def login(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def current_user
    return nil unless session[:session_token]

    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def require_user
    redirect_to new_session_url unless current_user
  end

  def logout
    current_user.try(:reset_session_token!)
    session[:session_token] = nil
  end

  def require_current_user
    redirect_to new_session_url unless current_user
  end
end
