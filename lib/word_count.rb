require 'natto'
require 'pp'
require 'find'

class WordCount 

  THESIS_ROOT_DIRECTORY = Rails.root.join('thesis_data')
   # こちらの配列に修造の名言を品詞分解したものを放り込んでいく。
  words_and_count = [] 
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
            s = n.surface 
            words << s
          end
        end
      end
    end
  end

  private
    # pathにはURLも可
    def extractText(path)
      data = Yomu.new path

      rawText = data.text
      rawText.gsub(/\r\n|\n|\r/, "")
    end

end
