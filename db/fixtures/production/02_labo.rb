8.times do |i|
  i += 1
  Labo.seed(:id) do |l|
    l.id = i
    l.name = Labo.ARRAY_LABO_NAMES[i-1]
    l.salt = ENV['PRODUCTION_LABO_SALT']
    l.crypted_password = Labo.crypt_password(ENV['PRODUCTION_LABO_PASSWORD'], ENV['PRODUCTION_LABO_SALT'])
  end
end

# ファイルからfeature_hashを取得
# 計算し直すときは以下の一行を使用
# feature_hash = FeaturesGetter.fetch(4)
# 実行時間の目安：論文3年分で約1時間
# (計測した環境：vagrant経由Ubuntu16.04，メモリ3GB，CPU2.4GHz1コア)
feature_hash = {}
File.open("lib/feature_hash.json") do |file|
  feature_hash = JSON.load(file)
end

## 空白を含むキーがあるため文字列で指定
lab_hash = {'鷲見研究室' => 'sumi', 'Dürst 研究室' => 'durst', '佐久田研究室' => 'sakuta',
            '大原研究室' => 'ohara', '小宮山研究室' => 'komiyama', '戸辺研究室' => 'tobe',
            '原田研究室' => 'harada', 'lopez 研究室' => 'lopez',
}

lab_hash.each do |key, value|
  labo = Labo.find_by!(name: key)
  labo.update!(features: feature_hash[value])
end
