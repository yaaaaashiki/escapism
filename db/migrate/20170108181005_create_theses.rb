class CreateTheses < ActiveRecord::Migration[5.0]
  def change
    create_table :theses do |t|
      t.text :body, :limit => 4294967295  # In MySQL -> LONGTEXT(MAX 4G Byte)
      t.text :summary
      t.text :title
      t.text :url
      t.integer :year
      t.references :labo, foreign_key: true
      t.references :author, foreign_key: true

      t.timestamps
    end
  end
end
