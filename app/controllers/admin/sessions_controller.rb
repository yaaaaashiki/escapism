class Admin::SessionsController < Admin::AdminController
  skip_before_action :require_admin_login

  def new
  end

  def create
    admin_user = AdminUser.find_by(username: params[:session][:username])
    if admin_user && admin_user.authenticate(params[:session][:password])
      admin_log_in(admin_user)
      redirect_back_or_to_admin_url(admin_url, notice: 'login succeed')
    else
      flash.now[:warning] = 'ユーザ名またはパスワードに誤りがあります。'
      render :new, status: :unauthorized
    end
  end

  def destroy
    admin_log_out
    redirect_to admin_sign_in_url, notice: 'Success logout'
  end
end
