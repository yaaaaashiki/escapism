2.times do |i|
  i += 1 
  Author.seed(:id) do |a|
    a.id = i
    a.name = ["松本 樹生", "佐久田 博"][i-1]
  end
end
