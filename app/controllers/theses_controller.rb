class ThesesController < ApplicationController
  before_action :init_set_popular_theses

  def index
    @labo_id = params[:l]
    query = params[:q]
    @search_field = params[:f]
    if search_theses?(query, @labo_id, @search_field)
      @theses = Thesis.search_by_keyword(query, @labo_id, @search_field).page(params[:page]).per(4)
      if not_exist_theses(@theses)
        flash[:alert] = 'Matching theses was not found. Try again'
      end
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

      @theses = Thesis.more_like_this(@thesis.id).page(params[:page]).per(4)
      @author = Author.all
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

    def search_theses?(query, labo_id, field)
      query.present? || (labo_id.to_i != Labo.NO_LABO_ID && !labo_id.nil?) || !field.nil?
    end

    def not_exist_theses(theses)
      theses.size == 0
    end
end
