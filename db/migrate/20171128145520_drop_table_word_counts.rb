class DropTableWordCounts < ActiveRecord::Migration[5.0]
  def change
    drop_table :word_counts
  end
end
