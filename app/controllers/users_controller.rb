class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :create]
  before_action :token_exists?, only:[:new]

  def new
    if invalid_size?(params[:token])
      render_414
      return
    end

    @user = User.new
    mail_address_id = Token.find_by!(token: params[:token]).mail_address_id
    if mail_address_id.nil?
      logger.error("Bad request: UserController new action 12 lines: mail_address_id is undefined")
      render_404
      return
    end

    # NOTE:↓これセッションに入れる意味なくね？？ @user.emailに入れればいいのでは？？
    session[:email] = MailAddress.find(mail_address_id).address
    if session[:email].nil?
      logger.error("Bad request: UserController new action 17 lines: session[:email] is undefined")
      render_404
      return
    end
  end

  def create
    @user = User.new(user_params)
    if @user.labo_student?
      labo = Labo.find_by(id: labo_password_params[:id])
      if labo.nil?
        @user.errors[:base] << "所属している研究室を選択してください。"
        render :new, status: :bad_request
        return
      end

      if !labo.authoricate(labo_password_params[:password])
        @user.errors[:base] << "研究室のパスワードが誤っています。"
        render :new, status: :bad_request
        return
      end
    else
      @user.labo = Labo::NO_LABO_ID
    end

    ActiveRecord::Base.transaction do
      @user.save!
      delete_token!
    end

    login(@user.email, user_params[:password])
    redirect_to users_path
    rescue ActiveRecord::RecordInvalid => e
      ErrorUtil.print_error_info(e)
      @user = e.record
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
        labo: params[:labo],
        role: params[:role]
      }
    end

    def labo_password_params
      params = strong_params
      {
        id: params[:labo],
        password: params[:labo_password]
      }
    end

    def token_exists?
      redirect_to root_path unless Token.exists?(token: params[:token])
    end

    def delete_token!
      mail_address = MailAddress.find_by!(address: @user.email)
      Token.find_by!(mail_address_id: mail_address.id).destroy!
    end
end
