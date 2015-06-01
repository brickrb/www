class AddProfileFieldstoUsers < ActiveRecord::Migration
  def change
    add_column :users, :full_name, :string
    add_column :users, :username, :string
    add_column :users, :website, :string
    add_column :users, :github_username, :string
    add_column :users, :twitter_username, :string
  end
end
