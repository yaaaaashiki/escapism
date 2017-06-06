class CreateMailAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :mail_addresses do |t|
      t.string :address :null => false

      t.timestamps
    end
  end
end
