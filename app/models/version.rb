class Version < ActiveRecord::Base
  belongs_to :package

  has_attached_file :tarball
  validates_attachment :tarball, :content_type => { :content_type => "tgz" }
end
