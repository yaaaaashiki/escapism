require 'json'

class CiniisController < ApplicationController
  def index
    array = []

    if params[:lab_id] && params[:feature]
      labo = Labo.all.find(params[:lab_id].keys[0])
      labo_feature_array = labo.features.to_a
      feature_id_array = params[:feature].keys

      feature_id_array.each do |id|
        array.push(labo_feature_array[id.to_i][0])
      end

      @results = create_results(array)
    elsif params[:q]
      array.push(params[:q])
      @results = create_results(array)
    end
  end

  def show
  end

  private
    def cinii_params
      params.permit(:lab_id, :feature)
    end

    def parse_json(json)
      JSON.parse(json)
    end

    def create_results(array)
      json = Api::CiniisSearchController.create_json(array)
      parse_json(json)
    end
end
