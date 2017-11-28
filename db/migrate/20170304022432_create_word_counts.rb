class CreateWordCounts < ActiveRecord::Migration[5.0]
  def change
    create_table :word_counts do |t|
      t.decimal :web, :precision => 9, :scale => 6
      t.decimal :ruby, :precision => 9, :scale => 6
      t.references :thesis, foreign_key: true

      t.timestamps
    
    end
  end
end
