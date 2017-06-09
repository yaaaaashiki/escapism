class CreateTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :tokens do |t|
      t.belongs_to :mail_address 
      t.string :token
      t.timestamps
    end
  end
end
