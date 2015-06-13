class Package < ActiveRecord::Base
  has_many :ownerships, dependent: :destroy
  has_many :users, through: :ownerships
  has_many :versions, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name

  def description
    if self.versions.any?
      self.versions.last.description
    else
      "null"
    end
  end

  def latest_version
    if self.versions.any?
      self.versions.last
    end
  end

  def latest_version_number
    if self.versions.any?
      self.versions.last.number
    else
      "null"
    end
  end

end
