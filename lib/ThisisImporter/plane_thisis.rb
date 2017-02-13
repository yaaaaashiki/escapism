class ThisisImporter::PlaneThisis
  attr_accessor :lines
  def initialize(path)
    data = Yomu.new(path) 
    rawText = data.text
    @liens = rawText.gsub(/\r\n|\n|\r/, "")
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

end
