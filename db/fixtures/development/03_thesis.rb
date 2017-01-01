6.times do |i|
  i += 1
  Thesis.seed(:id) do |t| 
    t.id = i
    t.author_id = [1,2,1,2,1,2][i-1]
    t.year = [2016, 2017, 2018, 2016, 2017, 2018][i-1]
    t.comment = '' 
    t.url = "/users/buntu/thesis_data/test#{i}.pdf"
    t.pdf_text = ["プロテウス効果が発生すると良いなwww", "Githubが使えると良いなwww", "Subversionよくわからんwww", "Ruby on Rails良いね！！", "Slack kkkkkwww", "mac欲しいけどお金ない(´；ω；｀)" ][i-1]
  end
end
