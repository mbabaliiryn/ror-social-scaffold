class AddDateOfBirthToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :DOB, :string
  end
end
