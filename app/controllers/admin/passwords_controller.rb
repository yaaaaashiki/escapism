class Admin::PasswordsController < Admin::AdminController
  before_action :set_user, only: [:show, :update]

  def index
    @users = User.all
  end

  def show
  end

  def update
    if @user.update(password_params)
      redirect_to admin_passwords_url
    else
      render :edit
    end
   end

  private
    def set_user
      @user = User.find(params[:id])
    end

  def password_params
    params.require(:user).permit(:password)
  end
end
