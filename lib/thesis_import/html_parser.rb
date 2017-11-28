class HTMLParser
  def self.parse_html_object(path)
    Nokogiri::HTML(File.open(path))
  end

  def self.parse_written_year(index_html)
    index_html.title.to_s.match(/\A20\w{2}/).to_s.to_i
  end
end
