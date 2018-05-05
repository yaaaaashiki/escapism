class Admin::UsersController < AdminController
  before_action :set_user, only: [:show, :update]

  def index
    @users = User.all
  end

  def new  
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_url, notice: 'user created'
    else
      render :new, status: :bad_request
    end
  end

  def update
    if @user.update(except_password_user_params)
      redirect_to admin_users_url
    else
      render :edit
    end
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password, :labo)
    end

    def except_password_user_params
      params.require(:user).permit(:username, :email, :labo)
    end
end

