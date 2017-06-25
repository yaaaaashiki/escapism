class Admin::UsersController < AdminController
  skip_before_filter :require_login, only: [:index, :new, :create]
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
      render :new
    end
  end

  def update
    if @user.update(except_password_user_params)
      redirect_to admin_url
    else
      render :index
    end
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :year, :email, :password, :labo)
    end

    def except_password_user_params
      params.require(:user).permit(:username, :year, :email, :labo)
    end
end

