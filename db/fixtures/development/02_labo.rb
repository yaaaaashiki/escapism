8.times do |i|
  i += 1
  Labo.seed(:id) do |l|
    l.id = i
    l.name = ['鷲見研究室', 'Dürst 研究室', '佐久田研究室', '大原研究室', '小宮山研究室', '戸辺研究室', '原田研究室', 'lopez 研究室'][i-1]
  end
end

# 最初から上のに合わせればよかったww
# lab_names = %w(duerst harada komiyama lopez ohara sakuta sumi tobe yamaguchi)
feature_hash = FeaturesGetter.fetch(4)
# 空白を含むキーがあるため文字列で指定
lab_hash = {'鷲見研究室' => 'sumi', 'Dürst 研究室' => 'duerst', '佐久田研究室' => 'sakuta',
            '大原研究室' => 'ohara', '小宮山研究室' => 'komiyama', '戸辺研究室' => 'tobe',
            '原田研究室' => 'harada', 'lopez 研究室' => 'lopez',
}

lab_hash.each do |key, value|
  labo = Labo.find_by!(name: key)
  labo.update!(features: feature_hash[value])
end
