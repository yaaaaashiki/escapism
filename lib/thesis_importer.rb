require "find"
require 'natto'
require 'pp'

module ThesisImporter
  THESIS_ROOT_DIRECTORY = Rails.root.join('thesis_data')
  CLIENT = Elasticsearch::Client.new log: true
  INDEX = 'thesis_development'
  TYPE = 'thesis'

  def upsert_all!
    Find.find(THESIS_ROOT_DIRECTORY) do |path|
      if path =~ /.*\.pdf$/
        plane_thesis = PlaneThesis.new(path)
        if plane_thesis.exists_tex? && !plane_thesis.exists_thesis?
          thesis = plane_thesis.thesis!
          text = plane_thesis.text
          insert_into_elasticsearch(thesis.id, text)
        end
      end
    end
  end
  
  def all_words_count
    total = {}
    Find.find(THESIS_ROOT_DIRECTORY) do |path|
      words_count = PlaneThesis.new(path).words_count if path =~ /.*\.pdf/ 
      total = sum_words_count(total, words_count)
    end
    total.select! {|key,val| val >= 60 } 
    puts total.sort {|(k1, v1), (k2, v2)| v2 <=> v1} 
    binding.pry 
    #puts total 

  end
  
  class PlaneThesis
    attr_accessor :text
    def initialize(path)
      @path = path
      data = Yomu.new(path) 
      rawText = data.text
      @text = rawText.gsub(/\r\n|\n|\r/, "")
      @tex_path = path.gsub(/pdf$/, "tex")
    end
    
    def words_count
      words = [] #とりあえずここで宣言
      words_count = {}

      nm = Natto::MeCab.new
      @lines.split.each do |row|
        nm.parse(row) do |n|
          words << n.surface  if n.feature.match(/(固有名詞|名詞,一般)/) && n.surface.length > 1
        end
      end

      words.each do |word|  
        if words_count.key?(word)
          words_count[word] += 1
        else
          words_count[word] = 1
        end
      end
      words_count
    end

    def exists_tex?
      File.exist?(@tex_path)
    end
    
    def exists_thesis?
        Thesis.exists?(url: @path)
    end
    
    def thesis!
      @thesis ||= Thesis.create_from_seed(metadatas)
    end
    
    def metadatas
      # メタデータの取得
      authorData = "unknown"
      titleData  = "notitle"
      dateData   = "unknown"
      yearData   = "unknown"

      File.open(@tex_path) do |file|
        file.each_line do |line|
          match = line.match(/author\{(.*?)\}/)
          authorData = match[1] if authorData == "unknown" && match

          match = line.match(/title\{(.*?)\}/)
          titleData  = match[1] if match
            
          match = line.match(/date\{(.*?)\}/)
          dateData   = match[1] if match

          match = line.match(/year\{(.*?)\}/)
          yearData   = match[1] if match
        end
      end
      { title: titleData, author_name: authorData, year: yearData, url: path }
    end

  end

  private

  def insert_into_elasticsearch(thesis_id, text)
    CLIENT.index(index: INDEX, type: TYPE, id: thesis_id, body: { 
        text: text
      }
    )
  end
  
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
