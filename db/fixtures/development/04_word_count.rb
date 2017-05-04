#ThesisImporter.upsert_all!
web_count, ruby_count = {}
web_count = ThesisImporter.web_count
ruby_count = ThesisImporter.ruby_count

web_count.each do |key, value| 
    WordCount.create!(thesis_id: key , web: value)
end

ruby_count.each do |key, value| 
  updater = WordCount.find_by!(thesis_id: key)
  updater.update!(thesis_id: key , ruby: value)
end

