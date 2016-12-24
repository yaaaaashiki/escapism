class AdminController < ApplicationController
  protect_from_forgery with: :exception
#  layout 'admin/layouts/application'
#  before_action :authenticate_admin_user!

#  def current_admin_user
#    if session[:admin_user_id].present?
#      @current_admin_user ||= AdminUser.find(session[:admin_user_id])
#    end
#  end
#  helper_method :current_admin_user
#
#  private
#
#  def authenticate_admin_user!
#    if session[:admin_user_id].nil?
#      redirect_to admin_sign_in_path, notice: 'ログインが必要です。'
#    end
#  end
end
