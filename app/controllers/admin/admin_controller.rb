class Admin::AdminController < ActionController::Base
  include Admin::SessionsHelper
  protect_from_forgery with: :exception
  layout 'admin/layouts/admin_lte_2'
  before_action :require_admin_login
end
