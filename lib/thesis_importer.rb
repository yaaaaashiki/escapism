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
  SYMBOL_LABO_NAMES = %i(duerst harada komiyama lopez ohara sakuta sumi tobe )

  def upsert_all!
    students = {}
    thesis_all_title = {}
    thesis_title_hash = {}
    thesis_url_hash = {}
    final = []

    SYMBOL_LABO_NAMES.each do |labo_name|
      students.store(labo_name, "")
      thesis_all_title.store(labo_name, "")
      thesis_title_hash.store(labo_name, "")
      thesis_url_hash.store(labo_name, "")
    end

    Find.find(LABO_THESIS_ROOT_DIRECTORY) do |labo_path|
      SYMBOL_LABO_NAMES.each do |labo_name|
        if File.basename(labo_path).include?("index.html")
          labo_path_array = []
          thesis_title_array = []
          current_path(labo_path)
          index_file = File.open(@labo_path)
          parse_html(index_file)
          set_thesis_year
          thesis_all_title[labo_name] = @labo_html.title if thesis_all_title[labo_name] == "" && @labo_path.include?(labo_name.to_s)
          @labo_html.css('td').each do |td_elements|
            td_elements.css('a').each do |anchor|
              set_thesis_path(anchor[:href])

              labo_path_array.push(return_full_path) if insert_thesis?

              if martin_thesis?
                thesis_title_array.push(td_elements.content)
              elsif harada_thesis?
                thesis_title_array.push(fetch_just_thesis_title(td_elements.previous.content))
              elsif sakuta_bachelor_thesis?
                thesis_title_array.push(fetch_just_thesis_title(td_elements.previous.previous.content))
              elsif insert_thesis?
                thesis_title_array.push(fetch_just_thesis_title(td_elements.content))
              end
            end
          end

          thesis_title_hash[labo_name] = thesis_title_array if thesis_title_hash[labo_name] == "" && @labo_path.include?(labo_name.to_s)
          thesis_url_hash[labo_name] = labo_path_array if thesis_url_hash[labo_name] == "" && @labo_path.include?(labo_name.to_s)

          if students[labo_name] == "" && @labo_path.include?(labo_name.to_s)
            labo_member = []
            @labo_html.css('tr').each do |tr_elem|
              labo_member.push(fetch_just_name(tr_elem.css('td')[1].content)) if tr_elem.css('td')[1]
              thesis_title_array.push(tr_elem.css('td')[2].content) if tr_elem.css('td')[2] && thesis_title_hash[labo_name] == "" && harada_path?
            end
            students[labo_name] = labo_member
          end
        end
      end
    end

    students.flatten.each do |labo|
      if labo.kind_of?(Array)
        labo.each do |student_name|
          final.push({author_name: student_name, year: @thesis_year})
        end
      end
    end

    count = 0

    thesis_title_hash.flatten.each do |labo|
      if labo.kind_of?(Array)
        labo.each do |thesis_title|
          final[count].store(:title, thesis_title)
          count = count + 1
        end
      end
    end

    count = 0
    
    thesis_url_hash.flatten.each do |labo|
      if labo.kind_of?(Array)
        labo.each do |thesis_url|
          final[count].store(:url, thesis_url)
          @insert_thesis = Thesis.create_from_seed(final[count])
          insert_thesis_into_elasticsearch(thesis_url)
          count = count + 1
        end
      end
    end

#    Find.find(THESIS_ROOT_DIRECTORY) do |path|
#      plane_thesis = PlaneThesis.new(path)
#      if plane_thesis.exists_tex? && !plane_thesis.exists_thesis?
#        plane_thesis.insert_into_elasticsearch
#      end
#    end
  
  end

  def current_path(labo_path)
    @labo_path = labo_path 
  end

  def set_text_content(thesis_path)
    data = Yomu.new(thesis_path)
    rawText = data.text
    rawText.gsub(/\r\n|\n|\r/, "")
  end

  def set_thesis_path(thesis_path)
    @thesis_path  = thesis_path
  end

  def parse_html(file)
    @labo_html = Nokogiri::HTML(file)
  end

  def set_thesis_year
    @thesis_year = @labo_html.title.to_s.match(/\A20\w{2}/).to_s.to_i
  end

  def return_full_path
    @thesis_path = @thesis_path.gsub(/\.\//, "") if martin_path?
    "#{@labo_path.gsub(/\/index\.html/, "")}/#{@thesis_path}"
  end

  def insert_thesis?
    common_thesis? || martin_thesis? || harada_thesis? || sakuta_bachelor_thesis?
  end

  def martin_path?
    @labo_path.include?("duerst")
  end

  def sakuta_path?
    @labo_path.include?("sakuta")
  end

  def harada_path?
    @labo_path.include?("harada")
  end

  def common_thesis?
    @thesis_path.match(/\Athesis.+/)
  end

  def martin_thesis?
    @thesis_path.match(/.+_T\.pdf/)
  end

  def sakuta_bachelor_thesis?
    @thesis_path.match(/\Aabstract\/undergraduate/)
  end

  def harada_thesis?
    @thesis_path.match(/\Aabs\/.+/) && !@thesis_path.match(/\Aabs\/.+E\.pdf\Z/)
  end

  def fetch_just_name(string)
    string.match(/\A\w{8}\s/) ? string.gsub!(/\A\w{8}\s/, "") : string
  end

  def fetch_just_thesis_title(string)
    string.match(/(:?\r\n)?\s/) ? string.gsub!(/(:?\r\n)?\s/, "") : string
  end

  def insert_thesis_into_elasticsearch(thesis_url)
    CLIENT.index(index: INDEX, type: TYPE, id: @insert_thesis.id, body: {
      text: set_text_content(thesis_url)
    })
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



  module_function :upsert_all!, :web_count, :ruby_count, :insert_thesis_into_elasticsearch
  module_function :parse_html, :set_thesis_year, :fetch_just_name, :fetch_just_thesis_title, :set_text_content
  module_function :sakuta_bachelor_thesis?, :harada_thesis?, :martin_thesis?, :common_thesis?, :insert_thesis?
  module_function :return_full_path, :martin_path?, :harada_path?, :sakuta_path?, :current_path, :set_thesis_path

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
