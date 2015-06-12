class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :oauth_applications, class_name: 'Doorkeeper::Application', as: :owner
  has_many :ownerships
  has_many :packages, through: :ownerships
  
  if Rails.env.production?
    after_create :purge_all
    after_save :purge
    after_destroy :purge, :purge_all
  end
end
