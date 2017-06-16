require "find"
require 'natto'
require 'pp'

module ThesisImporter
  THESIS_ROOT_DIRECTORY = Rails.root.join('thesis_data')
  LABO_THESIS_ROOT_DIRECTORY = THESIS_ROOT_DIRECTORY.join('ignore')
  CLIENT = Elasticsearch::Client.new log: true
  INDEX = 'thesis_development'
  TYPE = 'thesis'
  LABO_NAMES = %w(duerst harada komiyama lopez ohara sakuta sumi tobe )

  def upsert_all!
    students = {}
    thesis_all_title = {}
    thesis_title_hash = {}
    thesis_url_hash = {}
    LABO_NAMES.each do |labo_name|
      students.store(labo_name.to_sym, "")
      thesis_all_title.store(labo_name.to_sym, "")
      thesis_title_hash.store(labo_name.to_sym, "")
      thesis_url_hash.store(labo_name.to_sym, "")
    end

    Find.find(LABO_THESIS_ROOT_DIRECTORY) do |labo_path|
      LABO_NAMES.each do |labo_name|
        if File.basename(labo_path).include?("index.html")
          labo_path_array = []
          thesis_title_array = []
          index_file = File.open(labo_path)
          labo_html = parse_html(index_file)
          fetch_year(labo_html)
          
          thesis_all_title[labo_name.to_sym] = labo_html.title if thesis_all_title[labo_name.to_sym] == "" && labo_path.include?(labo_name)
          labo_html.css('td').each do |td_elements|
            td_elements.css('a').each do |anchor|
              if anchor[:href].match(/\Athesis.+/)
                labo_path_array.push(return_full_path(labo_path, anchor[:href]))
                thesis_title_array.push(fetch_just_thesis_title(td_elements.content))
              elsif anchor[:href].match(/.+_T\.pdf/)
                labo_path_array.push(return_full_path(labo_path, anchor[:href]))
                thesis_title_array.push(td_elements.content)
              elsif anchor[:href].match(/\Aabs\/.+/) && !anchor[:href].match(/\Aabs\/.+E\.pdf\Z/)
                labo_path_array.push(return_full_path(labo_path, anchor[:href]))
                thesis_title_array.push(fetch_just_thesis_title(td_elements.content))
              elsif  anchor[:href].match(/\Aabstract\/undergraduate/)
                labo_path_array.push(return_full_path(labo_path, anchor[:href]))
                thesis_title_array.push(fetch_just_thesis_title(td_elements.content))
              end
            end
          end

          thesis_title_hash[labo_name.to_sym] = thesis_title_array if thesis_title_hash[labo_name.to_sym] == "" && labo_path.include?(labo_name)
          thesis_url_hash[labo_name.to_sym] = labo_path_array if thesis_url_hash[labo_name.to_sym] == "" && labo_path.include?(labo_name)

          if students[labo_name.to_sym] == "" && labo_path.include?(labo_name)
            labo_member = []
            labo_html.css('tr').each do |tr_elem|
              labo_member.push(fetch_just_name(tr_elem.css('td')[1].content)) if tr_elem.css('td')[1]
            end
            students[labo_name.to_sym] = labo_member
          end
        end
      end
    end

    #puts thesis_all_title
    
    #students.each do |key, value|
    #  if thesis_title_hash.has_key?(key) && thesis_url_hash.has_key?(key)
    #    #students.value.each do |studenst|
    #    #{ title: title_data, author_name: author_data, year: year_data, date_data: date_data, url: @path }
    #    #end
    #    students[key] = value + thesis_title_hash.values_at(key) + thesis_url_hash.values_at(key)
    #  end
    #end
    #puts students
    #puts thesis_title_hash   
    #puts thesis_url_hash 

    final = []

    students.flatten.each do |labo|
      if labo.kind_of?(Array)
        labo.each do |student_name|
          final.push({author_name: student_name})
        end
      end
    end
  
    count = 0  #wwwwwwwwwwwwwwwwwwwwwwwwwwww
    
    thesis_url_hash.flatten.each do |labo|
      if labo.kind_of?(Array)
        labo.each do |thesis_url|
          binding.pry if final[count].nil?
          final[count].store(:url, thesis_url)
          count = count + 1
        end
      end
    end

#    final.each do |student_hash|
#      student_hash.store(key, value)
#    end

   puts final




  #puts thesis_url_hash 
 


  #[{title: hoge, kjkl}, {}, {}, {}, {}, {}]


#      author_data = "unknown"
#      title_data  = "notitle"
#      date_data   = "unknown"
#      year_data   = "unknown"
#
#      File.open(tex_path) do |file|
#        file.each_line do |line|
#          match = line.match(/author\{(.*?)\}/)
#          author_data = match[1] if author_data == "unknown" && match
#
#          match = line.match(/title\{(.*?)\}/)
#          title_data  = match[1] if match
#            
#          match = line.match(/date\{(.*?)\}/)
#          date_data   = match[1] if match
#
#          match = line.match(/year\{(.*?)\}/)
#          year_data   = match[1] if match
#        end
#      end
#      { title: title_data, author_name: author_data, year: year_data, date_data: date_data, url: @path }

#    Find.find(THESIS_ROOT_DIRECTORY) do |path|
#      plane_thesis = PlaneThesis.new(path)
#      if plane_thesis.exists_tex? && !plane_thesis.exists_thesis?
#        plane_thesis.insert_into_elasticsearch
#      end
#    end
  end

  def parse_html(file)
    Nokogiri::HTML(file)
  end

  def fetch_year(html)
    html.title.to_s.match(/\A20\w{2}/)
  end

  def return_full_path(labo_path, thesis_path)
    "#{labo_path.gsub(/\/index\.html/, "")}/#{thesis_path}"
  end

#  def fetch_labo_member(html, labo_name)
#    html.css('tr').each do |tr_elem|
#      #labo_member[labo_name.to_sym] << tr_elem.css('td')[1]
#    end
#
#    #puts labo_member
#  end

  def fetch_just_name(string)
    string.match(/\A\w{8}\s/) ? string.gsub!(/\A\w{8}\s/, "") : string
  end

  def fetch_just_thesis_title(string)
    string.match(/(:?\r\n)?\s/) ? string.gsub!(/(:?\r\n)?\s/, "") : string
  end

  def all_words_count
    total = {}
    Find.find(THESIS_ROOT_DIRECTORY) do |path|
      plane_thesis = PlaneThesis.new(path)
      if plane_thesis.validate_path?
        words_count = plane_thesis.words_count  
        total = sum_words_count(total, words_count)
      end
    end
    total.select! {|key,val| val >= 60 } 
    puts total.sort {|(k1, v1), (k2, v2)| v2 <=> v1} 
  end

  def web_count
    web_total = {}
    Find.find(THESIS_ROOT_DIRECTORY) do |path|
      plane_thesis = PlaneThesis.new(path)
      if plane_thesis.exists_thesis?
        web_words_count = plane_thesis.web_words_count  
        web_total = web_total.merge(web_words_count) 
      end
    end
    web_total
  end

  def ruby_count
    ruby_total = {}
    Find.find(THESIS_ROOT_DIRECTORY) do |path|
      plane_thesis = PlaneThesis.new(path)
      if plane_thesis.exists_thesis?
        ruby_words_count = plane_thesis.ruby_words_count  
        ruby_total = ruby_total.merge(ruby_words_count) 
      end
    end
    ruby_total
  end

  class PlaneThesis
    attr_accessor :text
    def initialize(path)
      @path = path
    end
    
    def text
      @text ||= if validate_path?
                  data = Yomu.new(@path) 
                  rawText = data.text
                  rawText.gsub(/\r\n|\n|\r/, "")
                end
    end

    def validate_path?
      @path =~ /.*\.pdf/
    end

    def tex_path
      @tex_path ||= @path.gsub(/pdf$/, "tex") if validate_path?
    end

    def words_count
      words_count = {}
      words.each do |word|  
        if words_count.key?(word)
          words_count[word] += 1
        else
          words_count[word] = 1
        end
      end
      words_count
    end

    def web_words_count
      web_words_count = {}
      total_words = 0
      thesis_id = Thesis.find_by!(url: @path).id
      web_words_count[thesis_id] = 0 
      words.each do |word|
        total_words += 1
        web_words_count[thesis_id] += 1 if word.include?("Web")
      end 
      web_words_count[thesis_id] = Rational(web_words_count[thesis_id], total_words)
      web_words_count
    end

    def ruby_words_count
      ruby_words_count = {}
      total_words = 0
      thesis_id = Thesis.find_by!(url: @path).id
      ruby_words_count[thesis_id] = 0 
      words.each do |word|
        total_words += 1
        ruby_words_count[thesis_id] += 1 if word.include?("Ruby")
      end 
      ruby_words_count[thesis_id] = Rational(ruby_words_count[thesis_id], total_words)
      ruby_words_count
    end

    def exists_tex?
      File.exist?(tex_path) if tex_path
    end
    
    def exists_thesis?
      Thesis.exists?(url: @path)
    end
    
    def thesis!
      @thesis ||= if exists_thesis?
                    Thesis.find_by!(url: @path)
                  else
                    Thesis.create_from_seed(metadatas)
                  end
    end

    def words
      if @words.blank?
        @words = [] #とりあえずここで宣言
        nm = Natto::MeCab.new
        text.each_line do |line|
          nm.parse(line) do |n|
            @words << n.surface  if n.feature.match(/(固有名詞|名詞,一般)/) && n.surface.length > 1
          end
        end
      end
      @words
    end
    
    def metadatas
      author_data = "unknown"
      title_data  = "notitle"
      date_data   = "unknown"
      year_data   = "unknown"

      File.open(tex_path) do |file|
        file.each_line do |line|
          match = line.match(/author\{(.*?)\}/)
          author_data = match[1] if author_data == "unknown" && match

          match = line.match(/title\{(.*?)\}/)
          title_data  = match[1] if match
            
          match = line.match(/date\{(.*?)\}/)
          date_data   = match[1] if match

          match = line.match(/year\{(.*?)\}/)
          year_data   = match[1] if match
        end
      end
      { title: title_data, author_name: author_data, year: year_data, date_data: date_data, url: @path }
    end

    def insert_into_elasticsearch
      CLIENT.index(index: INDEX, type: TYPE, id: thesis!.id, body: { 
          text: text
        }
      )
    end
  end



  module_function :upsert_all!, :web_count, :ruby_count
  module_function :parse_html, :fetch_year, :fetch_just_name, :fetch_just_thesis_title
  module_function :return_full_path

  private

  def sum_words_count(total, words_count)
    words_count.keys.each do |key|
      if total.key?(key)
        total[key] += words_count[key]
      else
        total[key] = words_count[key]
      end
    end
    total
  end
end
