class Admin::SessionsController < AdminController
  layout 'admin/layouts/admin_sign_in'
  skip_before_action :authenticate_admin_user!

  def new
  end

  def create
    admin_user = AdminUser.find_by_email(params[:email])
    if admin_user && admin_user.authenticate(params[:password])
      session[:admin_user_id] = admin_user.id
      redirect_to admin_dashboards_path, notice: 'ログインしました。'
    else
      flash.now[:warning] = 'ログインに失敗しました。'
      render :new
    end
  end

  def destroy
    session[:admin_user_id] = nil
    redirect_to admin_sign_in_path, notice: 'ログアウトしました。'
  end
end
