class MovePackageFieldsToVersions < ActiveRecord::Migration
  def change
    remove_column :packages, :license
    add_column :versions, :license, :string
  end
end
