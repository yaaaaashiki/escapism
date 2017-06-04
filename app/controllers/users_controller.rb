class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :create]

  def index
  end
 
  def new
    @user = User.new
  end

  def token
    if Token.exists?(token: params[:token]) 
      redirect_to new_user_url
    else
      redirect_to root_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to root_url
    else
      render :new 
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :year, :email, :password)
    end
end
