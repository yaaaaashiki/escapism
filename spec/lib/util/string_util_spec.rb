describe StringUtil do
  describe '#to_half_width_lowercase(from_str)' do
    describe 'error cases' do
      it 'when argument is a nil' do
        expect{StringUtil.to_half_width_lowercase(nil)}.to raise_error(ArgumentError)
      end

      it 'when argument is a Object' do
        expect{StringUtil.to_half_width_lowercase(Object)}.to raise_error(ArgumentError)
      end
    end

    describe 'normal cases' do
      it 'when argument is a half width lowercase string' do
        expect(StringUtil.to_half_width_lowercase("half width lowercase")).to eq "half width lowercase"
      end

      it 'when argument is a half width uppercase string' do
        expect(StringUtil.to_half_width_lowercase("HALF WIDTH UPPERCASE")).to eq "half width uppercase"
      end

      it 'when argument is a full width lowercase string' do
        expect(StringUtil.to_half_width_lowercase("ｆｕｌｌ　ｗｉｄｔｈ　ｌｏｗｅｒｃａｓｅ")).to eq "full width lowercase"
      end

      it 'when argument is a full width uppercase string' do
        expect(StringUtil.to_half_width_lowercase("ＦＵＬＬ ＷＩＤＴＨ ＵＰＰＥＲＣＡＳＥ")).to eq "full width uppercase"
      end

      it 'when argument is a japanese string' do
        expect(StringUtil.to_half_width_lowercase("日本語")).to eq "日本語"
      end

      it 'when argument is a empty string' do
        expect(StringUtil.to_half_width_lowercase("")).to eq ""
      end

      it 'when argument is a half width space' do
        expect(StringUtil.to_half_width_lowercase(" ")).to eq " "
      end

      it 'when argument is a full width space' do
        expect(StringUtil.to_half_width_lowercase("　")).to eq " "
      end

      it 'when argument is a tab' do
        expect(StringUtil.to_half_width_lowercase("\t")).to eq "\t"
      end

      it 'when argument is a half width marks string' do
        expect(StringUtil.to_half_width_lowercase("!\"#$%&'()=-~^|\\`@{[+;*:}]<,>.?/_")).to eq "!\"#$%&'()=-~^|\\`@{[+;*:}]<,>.?/_"
      end

      it 'when argument is a full width marks string' do
        expect(StringUtil.to_half_width_lowercase("！”＃＄％＆’（）＝ー～＾｜￥｀＠｛「＋；＊：｝」＜，＞．？・＿、。")).to eq "!\"#$%&'()=ー~^|￥`@{「+;*:}」<,>.?・_、。"
      end
    end
  end
end