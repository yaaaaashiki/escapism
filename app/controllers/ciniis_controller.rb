require 'json'
class CiniisController < ApplicationController
  def index
    array = []
    array.push(params[:q])
    if params[:q]
      json = Api::CiniisSearchController.create_json(array)
      @results = parse_json(json)
    end
  end

  def show
  end

  def parse_json(json)
    JSON.parse(json)
  end
end
