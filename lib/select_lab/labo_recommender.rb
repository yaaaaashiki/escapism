class LaboRecommender
  RECOMMENDER_PATH = Rails.root.join('lib/select_lab/classifier.py').to_s

  private_constant :RECOMMENDER_PATH

  def self.recommend(keyword)
    shell_script_safe_keyword = StringUtil.convert_to_shell_script_safe_from keyword
    recommend_keyword = shell_script_safe_keyword.gsub(/(\s|　)+/, ',')
    out, err, status = Open3.capture3('python3 ' + RECOMMENDER_PATH + ' ' + "\"#{recommend_keyword}\"")

    if err.present?
      raise err
    end

    out
  end
end
