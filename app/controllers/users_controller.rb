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
    @user.role = strong_params[:role].to_i
    if @user.role == User::LABO_STUDENT
      labo = Labo.all.find(labo_password_params[:id])
      if !labo.authoricate(labo_password_params[:password])
        render :new, status: :bad_request
        return
      end
    else
      @user.labo = nil
    end
    @user.save!  # && MailAddress.find_by(address: params[:user][:email])
    log_in @user
    session[:user_create] = true
    redirect_to users_path
  rescue ActiveRecord::RecordInvalid => e
    @user = e.record
    render :new, status: :bad_request
  rescue ActiveRecord::RecordNotFound => e
    render :new, status: :bad_request
  end

  private
    def strong_params
      params.require(:user).permit(:username, :email, :password, :labo, :labo_password, :role)
    end

    def user_params
      params = strong_params
      {
        username: params[:username],
        email: params[:email],
        password: params[:password],
        labo: params[:labo]
      }
    end

    def labo_password_params
      params = strong_params
      {
        id: params[:labo],
        password: params[:labo_password]
      }
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
