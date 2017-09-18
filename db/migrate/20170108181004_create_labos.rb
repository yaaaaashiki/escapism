class CreateLabos < ActiveRecord::Migration[5.0]
  def change
    create_table :labos do |t|
      t.string :name, :null => false
      t.text :features
      t.string :crypted_password, :limit => 32, :null => false
      t.string :salt, :string, :limit => 32, :null => false
      t.timestamps
    end
  end
end
