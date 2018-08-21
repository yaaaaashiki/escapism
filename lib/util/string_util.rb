class StringUtil
  class << self
    def to_half_width_lowercase(from_str)
      if !from_str.instance_of?(String)
        raise ArgumentError, "Argument(from_str) must be the String type not #{from_str.class}"
      end

      tmp = from_str.tr('０-９ａ-ｚＡ-Ｚ！”＃＄％＆’（）＝ー～＾｜￥｀＠｛「＋；＊：｝」＜，＞．？・＿、。　', '0-9a-zA-Z!"#$%&\'()=ー~^|￥`@{「+;*:}」<,>.?・_、。 ')
      tmp.downcase
    end

    def convert_to_shell_script_safe_from(text)
      return text.gsub(/\r|\n|\r\n/, '')
                 .tr("!\"#$%&'()=~\^|`@{[+;*:}]<,>.?/_", "！”＃＄％＆’（）＝～＾｜｀＠｛「＋；＊：｝」＜、＞．？・＿")
                 .gsub(/-/, '－')
                 .gsub(/\\/, '￥')
    end
  end
end
