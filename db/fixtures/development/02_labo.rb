8.times do |i|
  i += 1
  Labo.seed(:id) do |l|
    l.id = i
    l.name = Labo.ARRAY_LABO_NAMES[i-1]
    l.salt = "asdasdastr4325234324sdfds"
    l.crypted_password = Labo.crypt_password("password", "asdasdastr4325234324sdfds")
  end
end

# 最初から上のに合わせればよかったww
feature_hash = FeaturesGetter.fetch(4)
## 空白を含むキーがあるため文字列で指定
lab_hash = {'鷲見研究室' => 'sumi', 'Dürst 研究室' => 'durst', '佐久田研究室' => 'sakuta',
            '大原研究室' => 'ohara', '小宮山研究室' => 'komiyama', '戸辺研究室' => 'tobe',
            '原田研究室' => 'harada', 'lopez 研究室' => 'lopez',
}

lab_hash.each do |key, value|
  labo = Labo.find_by!(name: key)
  labo.update!(features: feature_hash[value])
end
