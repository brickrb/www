class Ownership < ActiveRecord::Base
  belongs_to :package
  belongs_to :user

  def email
    self.user.email
  end

  def fullname
    self.user.full_name
  end
end
