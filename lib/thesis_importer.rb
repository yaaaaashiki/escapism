require 'find'
require 'open3'

module ThesisImporter
  def upsert_all!(theses_year_dir)
    Find.find(theses_year_dir) do |path|
      if PathChecker.index_html_path?(path)
        index_html = HTMLParser.parse_html_object(path)
        written_year = HTMLParser.parse_written_year(index_html)

        index_html.css('tr').each do |tr_element|
          tr_element.css('td').each do |td_element|
            td_element.css('a').each do |a_element|
              if PathChecker.thesis_path?(a_element[:href])
                begin
                  thesis = Thesis.new
                  thesis.year = written_year

                  thesis.url = "#{path.gsub(/\/index\.html/, "")}/#{a_element[:href]}"
                  thesis.url = PathChecker.return_martin_labo_full_path(thesis.url) if thesis.belongs_to_martin_labo?

                  thesis.labo = Labo.find_by(name: Labo.parse_labo_name(path))

                  thesis.body = Thesis.extract_body(thesis.url)

                  summariser_name = String(Rails.root.join('lib/abstractor/abstract_creator.py'))
                  thesis.summary , err, status = Open3.capture3("python3 " + summariser_name + " " + thesis.url)

                  if thesis.belongs_to_martin_labo?
                    thesis.title = td_element.content
                  elsif thesis.belongs_to_harada_labo?
                    thesis.title = fetch_just_thesis_title(td_element.previous.content)
                  elsif thesis.belongs_to_sakuta_bachelor_thesis?
                    thesis.title = fetch_just_thesis_title(td_element.previous.previous.content)
                  else
                    thesis.title = fetch_just_thesis_title(td_element.content)
                  end

                  author_name = fetch_just_name(tr_element.css('td')[1].content)
                  author = Author.find_by(name: author_name)
                  if !author
                    author = Author.create(name: author_name)
                  end 
                  thesis.author = author

                  thesis.save
                  puts "saved:" + thesis.url
                rescue
                  puts "save failed!!:" + thesis.url
                end
              end
            end
          end
        end
      end
    end
  end
 
  def fetch_just_name(string)
    string.match(/\A\w{8}\s/) ? string.gsub!(/\A\w{8}\s/, "") : string
  end

  def fetch_just_thesis_title(string)
    string.match(/(:?\r\n)?\s/) ? string.gsub!(/(:?\r\n)?\s/, "") : string
  end

  module_function :upsert_all!
  module_function :fetch_just_name, :fetch_just_thesis_title
end
