class Admin::ThesesController < AdminController
  before_action :set_thesis, only: [:show, :update]

  def index
    @theses = Thesis.all
  end

  def create
    binding.pry
  end

  def new
    @theses = []
    @year_options = []
    today_year = Date.today.year
    (-1..1).each do |i|
      @year_options << [today_year + i, today_year + i]
    end

    @labos = Labo.all

    @number_of_registration_options = []
    @max_number_of_registration = 20
    (1..@max_number_of_registration).each do |i|
      @number_of_registration_options << [i, i]
    end

    @number_of_registration_others_options = []
    @max_number_of_registration_others_options = 4
    (1..@max_number_of_registration_others_options).each do |i|
      @number_of_registration_others_options << [i, i]
    end
  end

  def show
  end

  def update
    if @thesis.update(thesis_params)
      redirect_to admin_theses_url
    else
      render :show, status: :bad_request
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

