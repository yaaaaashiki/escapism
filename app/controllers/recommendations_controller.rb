require 'open3'

class RecommendationsController < ApplicationController
  def index
    if invalid_size?(params[:q])
      render_414
      return
    end

    if params[:q]
      recommended_lab_name = LaboRecommender.recommend(params[:q])

      if recommended_lab_name.blank?
        logger.error("Bad request: RecommendationController index action 6 lines: recommended_lab_name is undefined")
        render_404
        return
      end
      
      recommended_lab_name.gsub!(/[\r\n]/, "")
      @lab_name = Labo.LABO_HASH.key(recommended_lab_name)

      if @lab_name.blank?
        logger.error("Internal server error: RecommendationController index action 12 lines: @lab_name is undefined")
        render_500
        return
      end

      if Labo.exists?(name: @lab_name)
        labo = Labo.find_by(name: @lab_name)
        if labo.nil?
          logger.error("Internal server error: RecommendationController index action 20 lines: labo is undefined")
          render_500
          return
        end
        @feaures = labo.features.keys
        @labo_id = labo.id
      end
    end
  end
end
