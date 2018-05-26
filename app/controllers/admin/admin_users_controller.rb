class Admin::AdminUsersController < Admin::AdminController
  def create
    @admin_user = AdminUser.new(admin_user_params)

    if @admin_user.save
      redirect_to admin_path
    else
      render :new, status: :bad_request
    end
  end

  def new
    @admin_user = AdminUser.new
  end

  def edit
    @admin_user = current_admin_user
  end

  def update
    @admin_user = current_admin_user
 
    if @admin_user.update(admin_user_params)
      redirect_to admin_path
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    admin_user = current_admin_user
    admin_user.destroy
    redirect_to admin_path
  end

  private
    def admin_user_params
      params.require(:admin_user).permit(:username, :password, :password_confirmation)
    end
end
