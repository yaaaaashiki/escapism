7.times do |i|
  i += 1
  Labo.seed(:id) do |l|
    l.id = i
    l.name = ['鷲見研究室', 'Dürst 研究室', '佐久田研究室', '大原研究室', '小宮山研究室', '戸辺研究室', '原田研究室'][i-1]
  end
end
