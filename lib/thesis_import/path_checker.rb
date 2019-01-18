class PathChecker
  class << self
    def index_html_path?(path)
      File.basename(path).match(/index.html?/)
    end

    def thesis_path?(path)
      common_thesis_path?(path) || martin_thesis_path?(path) || harada_thesis_path?(path) || sakuta_thesis_path?(path) || yamaguchi_thesis_path?(path)
    end

    private

      def common_thesis_path?(path)
        path.match(/\Athesis.+/)
      end

      def martin_thesis_path?(path)
        path.match(/.+_[T|t]\.pdf/)
      end

      def harada_thesis_path?(path)
        path.match(/\Aabs\/.+/) && !path.match(/\Aabs\/.+E\.pdf\Z/)
      end

      def sakuta_thesis_path?(path)
        path.match(/\Aabstract\/undergraduate/)
      end

      def yamaguchi_thesis_path?(path)
        path.match(/(postgrad|undrgrad)\/.+.pdf/)
      end
  end
end
