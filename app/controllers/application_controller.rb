class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include SessionsHelper
  protect_from_forgery with: :exception
  before_action :require_login
  MAX_REQUEST_SIZE = 50
#  rescue_from ActiveRecord::RecordNotFound, with: :render_404
#  rescue_from ActionController::RoutingError, with: :render_404
#  rescue_from Exception, with: :render_500

  def render_404
    render file: Rails.root.join('public/404.html.slim'), status: 404, layout: 'application', content_type: 'text/html'
  end

  def render_414
    render file: Rails.root.join('public/414.html.slim'), status: 414, layout: 'application', content_type: 'text/html'
  end

  def render_500
    render file: Rails.root.join('public/500.html.slim'), status: 500, layout: 'application', content_type: 'text/html'
  end

  def invalid_size?(params)
    params.length >= MAX_REQUEST_SIZE if params.present?
  end

  private
   
  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end
end
