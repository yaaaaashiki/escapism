class CiniisController < ApplicationController
  def index
    array = []
    array.push(params[:q])
    @results = Api::CiniisSearchController.create_json(array) if params[:q]
  end

  def show
  end
end
