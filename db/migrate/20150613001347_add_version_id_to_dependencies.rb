class AddVersionIdToDependencies < ActiveRecord::Migration
  def change
    add_column :dependencies, :version_id, :integer
    add_index :dependencies, :version_id
  end
end
