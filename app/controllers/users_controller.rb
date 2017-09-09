class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :create]
  before_action :token_exists?, only:[:new]
  before_action :post_params?, only:[:index]
  before_action :init_user_create_session

  def index
  end
 
  def new
    if invalid_size?(params[:token])
      render_414
      return
    end

    @user = User.new
    mail_address_id = Token.find_by(token: params[:token]).mail_address_id
    if mail_address_id.nil?
      logger.error("Bad request: UserController new action 12 lines: mail_address_id is undefined")
      render_404
      return
    end
    session[:email] = MailAddress.find(mail_address_id).address
    if session[:email].nil?
      logger.error("Bad request: UserController new action 17 lines: session[:email] is undefined")
      render_404
      return
    end
  end

  def create
    @user = User.new(user_params)
    @user.save!  # && MailAddress.find_by(address: params[:user][:email])
    log_in @user
    session[:user_create] = true
    redirect_to users_path
  rescue ActiveRecord::RecordInvalid => e
    @user = e.record
    render :new, status: :bad_request
  end

  private
    def user_params
      params.require(:user).permit(:username, :year, :email, :password)
    end

    def init_user_create_session
      session[:user_create] = nil
    end

    def post_params?
      redirect_to root_path if session[:user_create].nil?
    end

    def token_exists?
      redirect_to root_path unless Token.exists?(token: params[:token])
    end
end
