class Package < ActiveRecord::Base
  has_many :ownerships
  has_many :users, through: :ownerships
  has_many :versions

  validates_presence_of :name
  validates_uniqueness_of :name
end
