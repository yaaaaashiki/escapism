class StringUtil
  def self.to_half_width_lowercase(from_str)
    if !from_str.instance_of?(String)
      raise ArgumentError, "Argument(from_str) must be the String type"
    end

    tmp = from_str.downcase
    tmp.tr('０-９ａ-ｚ！”＃＄％＆’（）＝ー～＾｜￥｀＠｛「＋；＊：｝」＜，＞．？・＿、。　', '0-9a-z!"#$%&\'()=ー~^|￥`@{「+;*:}」<,>.?・_、。 ')
  end
end