class Admin::UsersController < AdminController
  skip_before_filter :require_login, only: [:index, :new, :create]
  #layout 'users'
  
  def index
  end
 
  def new  
    @user = User.new
  end
 
  def create
    if user_params[:password] == params[:user][:password_confirmation]
      @user = User.new user_params 
      if @user.save
        redirect_to admin_users_url, notice: 'user created'
      else
        render :new
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :year, :email, :password, :password_confirmation)
    end
end

