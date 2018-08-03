class Admin::LabosController < Admin::AdminController
  before_action :set_labo, only: [:show, :update]

  def index
    @labos = Labo.all
  end

  def show
  end

  def update
    if @labo.update(crypted_password_params)
      redirect_to admin_labos_url
    else
      render :edit
    end
   end

  private
    def set_labo
      @labo = Labo.find(params[:id])
    end

    def crypted_password_params
      password = params.require(:labo).permit(:password)[:password]
      salt = Labo.create_salt
      salted = Labo.crypt_password(password, salt)
      {crypted_password: salted, salt: salt}
    end
end
