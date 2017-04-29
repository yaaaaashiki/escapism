class Admin::UsersController < AdminController
  skip_before_filter :require_login, only: [:index, :new, :create]
  
  def index
    @user = User.new
    @users = User.all
  end
 
  def new  
    @user = User.new
  end
 
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_url, notice: 'user created'
    else
      render :new
    end
  end

  def edit
    params[:user][:labo] && params[:user][:info]
    @user = User.find(params[:user][:info])
    @user.labo = params[:user][:labo]
    @user.save
    redirect_to admin_url
  end


  private
    def user_params
      params.require(:user).permit(:username, :year, :email, :password)
    end
end

