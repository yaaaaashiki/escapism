class ArticleParser
    def self.return_title(element)
      element.include?("<b>") ? remove_bold_tag(extract_title(element)) : extract_title(element)
    end

    def self.extract_title(element)
      element.at_css('div > dl > dt > a').text.strip
    end

    def self.remove_bold_tag(element)
      element.text.strip.gsub(/\<(:?\/)?b\>/, "")
    end
end
