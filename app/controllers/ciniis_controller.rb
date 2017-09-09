require 'json'

class CiniisController < ApplicationController
  before_action :init_cinii_query_session
  PER_PAGE_NUM = 4

  def index
    array = []

    if check_size(params)
      render_414
      return
    end

    if params[:lab_id] && params[:feature] && !session[:query]
      labo = Labo.all.find(params[:lab_id].keys[0])
      if labo.nil?
        logger.error("Internal server error: CiniisController index action 11 lines: labo is undefined")
        render_500
        return
      end

      labo_feature_array = labo.features.to_a
      feature_id_array = params[:feature].keys

      if feature_id_array.blank?
        logger.error("Bad request: CiniisController index action 18 lines: feature_id_array is undefined")
        render_404
        return
      end

      feature_id_array.each do |id|
        array.push(labo_feature_array[id.to_i][0])
      end

      @results = create_results(array)
      @page_number = params[:page_num].to_i

      session[:query] = array[0]
    elsif params[:q] || session[:query]
      array.push(params[:q])
      array.push(session[:query])
      @results = create_results(array)
      @page_number = params[:page_num].to_i
    end
  end

  def show
  end

  private

    def init_cinii_query_session
      session[:query] = nil if init_session_params?
    end

    def cinii_params
      params.permit(:lab_id, :feature)
    end

    def parse_json(json)
      JSON.parse(json)
    end

    def create_results(array)
      json = CiniisSearch.create_json(array)
      parse_json(json)
    end

    def init_session_params?
      params[:lab_id].blank? && params[:feature].blank? && params[:q].blank?
    end

    def check_size(params)
      invalid_size?(params[:q]) || invalid_size?(params[:feature]) || invalid_size?(params[:page_num]) || invalid_size?(params[:lab_id])
    end
end
