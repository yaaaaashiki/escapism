# == Schema Information
#
# Table name: word_counts
#
#  id         :integer          not null, primary key
#  web        :decimal(9, 6)
#  ruby       :decimal(9, 6)
#  thesis_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_word_counts_on_thesis_id  (thesis_id)
#

class WordCount < ApplicationRecord
  belongs_to :thesis
end
