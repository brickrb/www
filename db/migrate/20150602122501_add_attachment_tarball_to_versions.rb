class AddAttachmentTarballToVersions < ActiveRecord::Migration
  def self.up
    change_table :versions do |t|
      t.string :shasum
      t.attachment :tarball
    end
  end

  def self.down
    remove_attachment :versions, :tarball
    remove_column :versions, :shasum
  end
end
