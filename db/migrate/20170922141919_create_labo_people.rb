class CreateLaboPeople < ActiveRecord::Migration[5.0]
  def change
    create_table :labo_people do |t|
      t.references :labo, foreign_key: true
      t.integer :year
      t.integer :gender
      t.integer :number_of_people
      t.timestamps
    end
  end
end
