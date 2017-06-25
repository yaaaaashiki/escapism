class Admin::ThesesController < AdminController
  
  def index 
    @theses = Thesis.all
  end

  def show
    @thesis = Thesis.find(params[:id])
  end

  def update
    if 
      @thesis = Thesis.find(params[:thesis][:info])
      @thesis.labo_id = params[:thesis][:labo_id]
      @thesis.save
      redirect_to admin_url
    else
      render :index
    end
  end

  private

    def thesis_params
      params.require(:thesis).permit(:title, :year, :labo_id, :author_id)
    end

end

