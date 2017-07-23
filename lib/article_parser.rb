class ArticleParser

  def self.return_data(article, id)
    data = {
      "id": id,
      "title": return_title(article),
      "url": return_url(article) ,
      "author": return_author(article),
    }
  end

  private

    def self.return_title(element)
      title = extract_title(element)
      title.include?("<b>") ? remove_bold_tag(title) : title
    end

    def self.extract_title(element)
      element.at_css('div > dl > dt > a').text.strip
    end

    def self.remove_bold_tag(title)
      title.strip.gsub(/\<(:?\/)?b\>/, "")
    end

    def self.return_url(element)
      "http://ci.nii.ac.jp" + extract_url(element)
    end

    def self.extract_url(element)
      element.at_css('div > dl > dt > a')[:href]
    end
  
    def self.return_author(element)
      author = extract_author(element)  
      author.nil? ? author : author.gsub(/(\s|\t)+/, '')
    end

    def self.extract_author(element)
      element.at_css('dd > p:first').children.to_s.strip
    end
end
