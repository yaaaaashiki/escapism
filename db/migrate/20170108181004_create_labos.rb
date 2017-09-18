class CreateLabos < ActiveRecord::Migration[5.0]
  def change
    create_table :labos do |t|
      t.string :name, :null => false
      t.text :features
      t.string :crypted_password
      t.string :salt
      t.timestamps
    end
  end
end
