module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
    cookies.signed[:user_id] = user.id
  end

 def admin_log_in(user)
    session[:admin_user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def admin_logged_in?
    !current_admin_user.nil?
  end

  def log_out
    session.delete(:user_id)
    cookies.signed[:user_id] = nil
    @current_user = nil
  end

  def admin_log_out
    session[:admin_user_id] = nil
  end

end
