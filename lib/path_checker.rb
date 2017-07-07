class PathChecker
  def self.index_html_path?(path)
    File.basename(path).include?("index.html")
  end

  def self.thesis_path?(path)
    self.common_thesis_path?(path) || self.martin_thesis_path?(path) || self.harada_thesis_path?(path) || self.sakuta_thesis_path?(path)
  end

  def self.return_martin_labo_full_path(path)
    path.gsub(/\.\//, "")
  end

  private

    def self.common_thesis_path?(path)
      path.match(/\Athesis.+/)
    end

    def self.martin_thesis_path?(path)
      path.match(/.+_T\.pdf/)
    end

    def self.harada_thesis_path?(path)
      path.match(/\Aabs\/.+/) && !path.match(/\Aabs\/.+E\.pdf\Z/)
    end

    def self.sakuta_thesis_path?(path)
      path.match(/\Aabstract\/undergraduate/)
    end
end
