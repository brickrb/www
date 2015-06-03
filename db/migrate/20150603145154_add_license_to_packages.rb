class AddLicenseToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :license, :string
  end
end
