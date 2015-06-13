class Dependency < ActiveRecord::Base
  belongs_to :version

  validates_presence_of :name
  validates_presence_of :version_constraint
end
