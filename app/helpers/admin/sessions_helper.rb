module Admin::SessionsHelper
  def admin_log_in(admin)
    session[:admin_user_id] = admin.id
  end

  def current_admin_user
    @current_admin_user ||= AdminUser.find_by(id: session[:admin_user_id])
  end

  def admin_logged_in?
    !current_admin_user.nil?
  end

  def admin_log_out
    session.delete(:admin_user_id)
    @current_admin_user = nil
  end

  def redirect_back_or(url, flash_hash = {})
    redirect_to(session[:return_to_urll] || url, flash_hash)
    session[:return_to_urll] = nil
  end

  def require_admin_login
    unless admin_logged_in?
      session[:return_to_urll] = request.url if request.get? && !request.xhr?
      redirect_to admin_sign_in_path, alert: 'ログインしてください'
    end
  end
end
