class UserSessionsController < ApplicationController
  skip_before_filter :require_login, except: [:destroy]
  
  def new
    @user = User.new
    @bookBack = true
  end
 
  def create
    if @user = login(params[:session][:username], params[:session][:password])
      log_in @user 
      render :index 
    else
      flash.now[:alert] = 'Login failed'
      render :new 
    end
  end
 
  def destroy
    logout
    redirect_to root_url 
  end
end
