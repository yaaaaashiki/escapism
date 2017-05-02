class Admin::ThesesController < AdminController
  
  def index 
    @theses = Thesis.all
  end

  def edit
    if params[:thesis][:labo] && params[:thesis][:info]
      @thesis = Thesis.find(params[:thesis][:info])
      @thesis[:labo] = (params[:thesis][:labo])
      @thesis.save
      redirect_to admin_url
    end
  end
end
