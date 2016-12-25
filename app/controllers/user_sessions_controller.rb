class UserSessionsController < ApplicationController
  skip_before_filter :require_login, except: [:destroy]
  
  def new
    @user = User.new
  end
 
  def create
    if @user = login(params[:username], params[:password])
      log_in @user 
      render 'index' 
    else
      flash.now[:alert] = 'Login failed'
      render 'new'
    end
  end
 
  def destroy
    logout
    redirect_to root_url 
  end
end
