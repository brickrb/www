class AddDescriptionToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :description, :text
  end
end
