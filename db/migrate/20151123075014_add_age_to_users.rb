class AddAgeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_name, :string
    add_column :users, :area, :string
  end
end
