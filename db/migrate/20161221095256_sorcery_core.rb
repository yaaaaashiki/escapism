class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username,            :null => false
      t.integer :year 
      t.string :email,           :null => false  
      t.integer :labo
      t.integer :role
      t.string :crypted_password
      t.string :salt
      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
  end
end
