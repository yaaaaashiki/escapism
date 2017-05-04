class Admin::ThesesController < AdminController
  
  def index 
    @theses = Thesis.all
  end

  def update
    if params[:thesis][:labo_id] && params[:thesis][:info]
      @thesis = Thesis.find(params[:thesis][:info])
      @thesis.labo_id = params[:thesis][:labo_id]
      @thesis.save
      redirect_to admin_url
    else
      render 'index'
    end
  end
end
