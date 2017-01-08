class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:index, :new, :create]
  before_filter :invitation_mail, only: [:new, :create]  
  layout 'users'
  
  def index
    #@user = User.all
  end
 
  def new  
    @user = User.new
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


    def invitation_mail 
 
    
    end




end
