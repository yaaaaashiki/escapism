24.times do |i|
  i += 1
  Message.seed(:id) do |u|
    u.id = i
    u.body = ['痩せたい', 'キレイになりたい', '昼夜逆転を直したい', '研究室は忙しいですか？', '論文はつらいですか？', 'パソコンは何台ありますか？', 'typescript すてき', '研究研究とってもたのしい', 'でもやっぱり escapism'][i%9]
    u.user_id = i % 8 + 1
    u.labo_id = i % 8 + 1
  end
end