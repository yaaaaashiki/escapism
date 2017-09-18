class Admin::LabosController < AdminController
  before_action :set_labo, only: [:show, :update, :crypted_password_params]

  def index
    @labos = Labo.all
  end

  def show
  end

  def update
    if @labo.update(crypted_password_params(params[:id]))
      redirect_to admin_labos_url
    else
      render :edit
    end
   end

  private
    def set_labo
      @labo = Labo.find(params[:id])
    end

    def crypted_password_params(id)
      password = params.require(:labo).permit(:password)[:password]
      @labo.set_salt
      salted = Labo.crypt_password(password, @labo.salt)
      {crypted_password: salted}
    end
end
