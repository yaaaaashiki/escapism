class ThesisData
  attr_accessor :text
  attr_accessor :labName

  def initialize(path, labName)
    @text    = extractText(path)
    @labName = labName
  end

  def extractText(path)
    data = Yomu.new(path) 
    rawText = data.text
    rawText = rawText.gsub(/\r\n/, "")
    rawText = rawText.gsub(/\n/, "")
    rawText = rawText.gsub(/\r/, "")
    # CSV用にカンマを変換
    rawText.gsub(/,/, "，")
  end
end