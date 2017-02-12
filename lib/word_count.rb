require 'natto'
require 'pp'
require 'find'

class WordCount 

  THESIS_ROOT_DIRECTORY = Rails.root.join('thesis_data')
   # こちらの配列に修造の名言を品詞分解したものを放り込んでいく。

  arraytext = [] 
  # csvファイルを読み込む。1行ずつ処理。

  def ThesisWordCount

    words = [] #とりあえずここで宣言

    Find.find(THESIS_ROOT_DIRECTORY) do |path|
      if path =~ /.*\.pdf/
        text = extractText(path)
        arraytext = text.split
        nm = Natto::MeCab.new
        arraytext.each do |row|
          nm.parse(row) do |n|
             words << n.surface  if (n.feature.match(/(固有名詞|名詞,一般)/)) and (n.surface.length > 1)
          end
        end
      end
    end
    words_count = [] 

    words.uniq.map do |word|  
        words_count[words_count.size] = ["#{word}", "#{words.grep(word).count}"] if word
    end
 
    pp words_count.sort_by { |word_count| word_count[1].to_i }.reverse

  end

  private
    # pathにはURLも可
    def extractText(path)
      data = Yomu.new path
      rawText = data.text
      rawText.gsub(/\r\n|\n|\r/, "")
    end

end
