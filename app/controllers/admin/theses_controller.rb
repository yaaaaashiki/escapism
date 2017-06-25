class Admin::ThesesController < AdminController
  before_action :set_thesis, only: [:show, :update]

  def index 
    @theses = Thesis.all
  end

  def show
  end

  def update
    if @thesis.update(thesis_params)
      redirect_to admin_url
    else
      render :index
    end
  end

  private

    def set_thesis
      @thesis = Thesis.find(params[:id])
    end

    def thesis_params
      params.require(:thesis).permit(:title, :year, :labo_id, :author_id)
    end

end

