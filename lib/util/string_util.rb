class StringUtil
  def self.to_half_width_lowercase(from_str)
    tmp = from_str.downcase
    tmp.tr('０-９ａ-ｚ！”＃＄％＆’（）＝ー～＾｜￥｀＠｛「＋；＊：｝」＜，＞．？・＿、。　', '0-9a-z!"#$%&\'()=ー~^|￥`@{「+;*:}」<,>.?・_、。 ')
  end
end