class CreateTheses < ActiveRecord::Migration[5.0]
  def change
    create_table :theses do |t|
      t.text :title
      t.text :url
      t.integer :year
      t.integer :labo_id
      t.references :author, foreign_key: true

      t.timestamps
    end
  end
end
