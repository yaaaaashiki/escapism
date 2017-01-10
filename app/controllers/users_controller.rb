class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:index, :new, :create]
  before_filter :invitation_mail, only: [:new, :create]  
  #layout 'users'
  
  def index
    #@user = User.all
    @bookBack = true
  end
 
  def new  
    @bookBack = true
    @user = User.new
    if Token.exists?(token: params[:token]) 
      redirect_to search_url
    else
      redirect_to root_path 
    end
  end
 
  def create
    @user = User.new(user_params) 
    if @user.save
      log_in @user
      flash.now[:success] = "succeed registration"
      redirect_to users_url 
    else
      flash.now[:notice] = "false registration"
      @bookBack = true
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
