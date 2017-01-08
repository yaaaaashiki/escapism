class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:index, :new, :create]
  
  def index
    #@user = User.all
    @root     = true
    @bookBack = true
  end
 
  def new  
    @user = User.new
    @bookBack = true
  end
 
  def create
    @user = User.new(user_params) 
    if @user.save
      log_in @user
      flash.now[:success] = "succeed registration"
      redirect_to users_url 
    else
      flash.now[:notice] = "false registration"
      render :new 
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :year, :email, :password, :password_confirmation)
    end
end
