class AddColToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :birthday, :date
    add_column :users, :gender, :boolean
    add_column :users, :articals_count, :integer
  end
end
