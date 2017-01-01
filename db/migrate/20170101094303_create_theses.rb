class CreateTheses < ActiveRecord::Migration[5.0]
  def change
    create_table :theses do |t|
      t.integer :author_id
      t.string :year
      t.string :comment
      t.string :url
      t.string :pdf_text

      t.timestamps
    end
  end
end
