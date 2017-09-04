class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  
  def new
    @user = User.new
  end
 
  def create
    if @user = login(params[:session][:email], params[:session][:password])
      log_in @user 
      redirect_to theses_url
    else
      flash.now[:alert] = 'Login failed. Please try again'
      render :new, status: :unauthorized
    end
  end
 
  def destroy
    logout
    redirect_to root_url 
  end
end
