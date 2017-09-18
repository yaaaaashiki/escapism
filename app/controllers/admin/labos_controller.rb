class Admin::LabosController < AdminController
  def index
    @labos = Labo.all
  end

  def show
  end
end
