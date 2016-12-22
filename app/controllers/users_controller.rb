class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:index, :new, :create]
 
  def index
    #@user = User.all
  end
 
  def new  
    @user = User.new
  end
 
  def create
    @user = User.new(user_params) 
    if @user.save
      redirect_to(:users, notice: 'User was successfully created')
    else
      flash[:notice] = "false registration"
      render "new"
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
