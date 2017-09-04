class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  
  def new
    @user = User.new
    @bookBack = true
  end
 
  def create
    if @user = login(params[:session][:email], params[:session][:password])
      log_in @user 
      redirect_to theses_url
    else
      flash.now[:alert] = 'Login failed'
      @bookBack = true
      render :new 
    end
  end
 
  def destroy
    logout
    redirect_to root_url 
  end
end
