class RecommendationsController < ApplicationController
  def index
    if params[:q]
      @labName = predict(params[:q])
    end
  end

  private

    def predict(keyword = "")
      classifier = String(Rails.root.join('lib/select_lab/classifier.py'))
      out, err, status = Open3.capture3("python3 " + classifier + " " + keyword)
      # outのみ返す
      return out 
    end
end
