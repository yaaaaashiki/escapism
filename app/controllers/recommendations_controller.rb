require 'open3'

class RecommendationsController < ApplicationController
  def index
    if params[:q]
      predicted_lab_name = predict(params[:q])
      if predicted_lab_name.nil?
        logger.error("Bad request: RecommendationController index action 6 lines: predicted_lab_name is undefined")
        render_404
      end
      predicted_lab_name.gsub!(/[\r\n]/, "")
      @lab_name = Labo.LABO_HASH.key(predicted_lab_name)

      if @lab_name.nil?
        logger.error("Internal server error: RecommendationController index action 12 lines: @lab_name is undefined")
        render_500
      end

      if Labo.exists?(name: @lab_name)
        labo = Labo.find_by(name: @lab_name)
        if labo.nil?
          logger.error("Internal server error: RecommendationController index action 20 lines: labo is undefined")
          render_500
        end
        @feaures = labo.features.keys
        @labo_id = labo.id
      end
    end
  end

  private
    def predict(keyword = "")
      classifier = String(Rails.root.join('lib/select_lab/classifier.py'))
      out, err, status = Open3.capture3("python3 " + classifier + " " + keyword)
      if err.present?
        logger.error(err)
        render_404
      end
      out
    end
end
