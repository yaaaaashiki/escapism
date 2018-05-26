class Admin::AdminController < ActionController::Base
  include Admin::SessionsHelper
  protect_from_forgery with: :exception
  layout 'admin/layouts/admin_lte_2'
  before_action :require_admin_login

  def redirect_back_or_to_admin_url(url, flash_hash = {})
    redirect_to(session[:return_to_url] || admin_url, notice: 'login succeed')
    session[:return_to_url] = nil
  end

  private
    def require_admin_login
      unless admin_logged_in?
        session[:return_to_url] = request.url if request.get? && !request.xhr?
        redirect_to admin_sign_in_path, alert: 'ログインしてください'
      end
    end
end
