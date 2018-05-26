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
end
