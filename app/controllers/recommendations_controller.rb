require 'open3'

class RecommendationsController < ApplicationController
  def index
    if params[:q]
      binding.pry
      predicted_lab_name = predict(params[:q])
      lab_hash = {'鷲見研究室' => 'sumi'  , 'Dürst 研究室' => 'duerst'  , '佐久田研究室' => 'sakuta'   ,
                  '大原研究室' => 'ohara' , '小宮山研究室' => 'komiyama', '戸辺研究室'   => 'tobe'     ,
                  '原田研究室' => 'harada', 'lopez 研究室'  => 'lopez'   , # '山口研究室'   => 'yamaguchi',
      }
      predicted_lab_name.gsub!(/[\r\n]/, "")
      @lab_name = lab_hash.key(predicted_lab_name)
      if Labo.exists?(name: @lab_name)
        labo = Labo.find_by(name: @lab_name)
        @feaures = labo.features.keys
      end
    end
  end

  private

    def predict(keyword = "")
      classifier = String(Rails.root.join('lib/select_lab/classifier.py'))
      out, err, status = Open3.capture3("python3 " + classifier + " " + keyword)
      out
    end
end
