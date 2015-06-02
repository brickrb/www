class AddPackageIdToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :package_id, :integer
    add_index :versions, :package_id
  end
end
