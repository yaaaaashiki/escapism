require 'open3'

class RecommendationsController < ApplicationController
  def index
    if params[:q]
      predicted_lab_name = predict(params[:q])
      predicted_lab_name.gsub!(/[\r\n]/, "")
      @lab_name = Labo.LABO_HASH.key(predicted_lab_name)
      if Labo.exists?(name: @lab_name)
        labo = Labo.find_by(name: @lab_name)
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
