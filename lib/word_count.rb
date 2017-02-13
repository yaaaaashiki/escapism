require 'natto'
require 'pp'
require 'find'

class WordCount 

  THESIS_ROOT_DIRECTORY = Rails.root.join('thesis_data')

  arraytext = [] 

  def all_words_count
    total = {}
    Find.find(THESIS_ROOT_DIRECTORY) do |path|
      total = thesis_words_count(path, total) if path =~ /.*\.pdf/ 
    end
    total.select! {|key,val| val >= 60 } 
    puts total.sort {|(k1, v1), (k2, v2)| v2 <=> v1} 
    binding.pry 
    #puts total 

  end

  def thesis_words_count(path, words_count = {})
    words = [] #とりあえずここで宣言

    nm = Natto::MeCab.new
    extract_text(path).split.each do |row|
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

  private
    # pathにはURLも可
    def extract_text(path)
      data = Yomu.new path
      rawText = data.text
      rawText.gsub(/\r\n|\n|\r/, "")
    end

end
