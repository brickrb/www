if Rails.env.staging? || Rails.env.production?
  module ActiveRecordExtension
    extend ActiveSupport::Concern

    included do
      after_create :purge_all
      after_save :purge
      after_destroy :purge, :purge_all
    end

    ActiveRecord::Base.send(:include, ActiveRecordExtension)
  end
end
