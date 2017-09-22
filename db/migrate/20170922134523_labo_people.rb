class LaboPeople < ActiveRecord::Migration[5.0]
  def change
    t.references :labo, foreign_key: true
    t.integer :year
    t.integer :gender
    t.integer :number_of_people
  end
end
