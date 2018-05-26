class Admin::ThesesController < Admin::AdminController
  before_action :set_thesis, only: [:show, :update]

  MAX_NUMBER_OF_REGISTRATION = 20
  MAX_NUMBER_OF_REGISTRATION_OTHERS_OPTIONS = 4 

  def index
    @theses = Thesis.all
  end

  def create
    year = params[:year]
    labo_id = params[:labo][:id]
    directory = params[:directory]
    number_of_registration = params[:number_of_registration]
    theses_information = params[:theses]
    
    Thesis.save_from_admin_theses_new(year, labo_id, directory, number_of_registration, theses_information)
    
    directory.each do |file|
      file.close true
    end

    # path = IndexHtmlCreator.create(year, labo_id, number_of_registration, theses_information)
    # send_file path, :filename => 'index.html', disposition: :attachment
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
    @max_number_of_registration = MAX_NUMBER_OF_REGISTRATION
    (1..@max_number_of_registration).each do |i|
      @number_of_registration_options << [i, i]
    end

    @number_of_registration_others_options = []
    @max_number_of_registration_others_options = MAX_NUMBER_OF_REGISTRATION_OTHERS_OPTIONS
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

