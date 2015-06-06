class Version < ActiveRecord::Base
  belongs_to :package

  has_attached_file :tarball
  validates_attachment :tarball, :content_type => { :content_type => "application/x-gzip" }

  validates_presence_of :tarball
  validates_uniqueness_of :number
end
