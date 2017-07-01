class ThesesController < ApplicationController
  before_action :init_set_popular_theses

  def index
    @labo_id = params[:l]
    query = params[:q]
    if @labo_id.present? || query.present?
      @theses = Thesis.search_by_keyword(query, @labo_id).page(params[:page]).per(4)
    end

    @author = Author.all
    @labos = Labo.all
  end

  def show
    @thesis = Thesis.find(params[:id])
    if @thesis
      impressionist(@thesis)
      if @thesis.impressionist_count.nil?
        @thesis.update_attribute(:access, 0)
      else
        @thesis.update_attribute(:access, @thesis.impressionist_count(:filter=>:all))
      end
    end

    @labos = Labo.all
  end

  def download
    thesis = Thesis.find params[:id]
    send_file(thesis.url, disposition: :inline)
  end

  private
    def init_set_popular_theses
      @popular_theses = Thesis.all.order(access: :desc).limit(5)
    end

end
