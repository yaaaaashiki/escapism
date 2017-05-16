class AddAccessToTheses < ActiveRecord::Migration[5.0]
  def change
    add_column :theses, :access, :integer
  end
end
