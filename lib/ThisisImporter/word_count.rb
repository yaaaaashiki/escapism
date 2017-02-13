require 'natto'
require 'pp'
require 'find'

class ThisisImporter::WordCount 

  THESIS_ROOT_DIRECTORY = Rails.root.join('thesis_data')

  def all_words_count
    total = {}
    Find.find(THESIS_ROOT_DIRECTORY) do |path|
      words_count = ThisisImporter::PlaneThisis.new(path).words_count if path =~ /.*\.pdf/ 
      total = sum_words_count(total, words_count)
    end
    total.select! {|key,val| val >= 60 } 
    puts total.sort {|(k1, v1), (k2, v2)| v2 <=> v1} 
    binding.pry 
    #puts total 

  end

  def sum_words_count(total, words_count)
    words_count.keys.each do |key|
      if total.key?(key)
        total[key] += words_count[key]
      else
        total[key] = words_count[key]
      end
    end
    total
  end
end
