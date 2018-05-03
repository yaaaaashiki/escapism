class Summarizer
  MECAB_DIR = %x(echo `mecab-config --dicdir`'/mecab-ipadic-neologd').chomp
  SUMMARIZER_PATH = Rails.root.join('lib', 'text_summarizer', 'summarizer.py').to_s
  SUMMARIZE_COMMAND = "python3 #{SUMMARIZER_PATH}"
  MAX_SUMMARIZEABLE_WORD_COUNT = 60000

  private_constant :MECAB_DIR, :SUMMARIZER_PATH, :SUMMARIZE_COMMAND, :MAX_SUMMARIZEABLE_WORD_COUNT

  @@mecab = Natto::MeCab.new(output_format_type: :wakati, dicdir: MECAB_DIR)

  def self.summarize(text)
    # NOTE:いい感じに変換する方法ないかな？？
    text_for_summarize = text.gsub(/\r|\n|\r\n/, '')
                             .tr("!\"#$%&'()=~\^|`@{[+;*:}]<,>.?/_", "！”＃＄％＆’（）＝～＾｜｀＠｛「＋；＊：｝」＜、＞．？・＿")
                             .gsub(/-/, '－')
                             .gsub(/\\/, '￥')
                             .gsub(/[。．.]/, '. ')

    wakati_text_for_summarize = @@mecab.parse(text_for_summarize)

    command = SUMMARIZE_COMMAND + " \"#{wakati_text_for_summarize[0, MAX_SUMMARIZEABLE_WORD_COUNT]}\""
    summary, err, status = Open3.capture3 command

    raise err if err.blank? == false

    summary.gsub(/\s/, "")
  end
end