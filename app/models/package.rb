class Package < ActiveRecord::Base
  has_many :ownerships

  validates_presence_of :name
  validates_uniqueness_of :name
end
